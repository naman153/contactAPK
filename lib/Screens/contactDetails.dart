import 'package:contacts/Controllers/ContactController.dart';
import 'package:contacts/Models/Contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;
  const ContactDetails({required this.contact, Key? key}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    firstNameController.text=widget.contact.firstName.toString();
    lastNameController.text=widget.contact.surName.toString();
    phoneController.text=widget.contact.phoneNumber.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
              contactDetailSheet(context);
              }, icon: Icon(Icons.edit_outlined)),
            IconButton(onPressed: (){
              contactController.deleteContact(widget.contact.uid.toString()).then((value){
                contactController.contactsList.removeWhere((element) => element.uid == widget.contact.uid);
                Navigator.pop(context);
                contactController.contactsList.refresh();
              });
            }, icon: Icon(Icons.delete_outline_outlined)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.pink,
                  child: Text(widget.contact.firstName![0].toUpperCase(), style: TextStyle(fontSize: 60, color: Colors.white),),
                )
              ],
            ),
            const SizedBox(height: 60,),
            Text(widget.contact.firstName.toString() +" " +widget.contact.surName.toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
            const SizedBox(height: 20,),
            const Divider(thickness: 1.7,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                  onPressed: (){},
                  child: Column(
                    children: [
                      Icon(Icons.call, color: Colors.indigo.shade500,size: 30,),
                      SizedBox(height: 10,),
                      Text("Call", style: TextStyle(color: Colors.indigo.shade500, fontSize: 18, fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
                SizedBox(width: 200,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                  onPressed: (){},
                  child: Column(
                    children: [
                      Icon(Icons.message_outlined, color: Colors.indigo.shade500,size: 30,),
                      SizedBox(height: 10,),
                      Text("Text", style: TextStyle(color: Colors.indigo.shade500, fontSize: 18, fontWeight: FontWeight.w500),)
                    ],
                  ),
                )
              ],
            ),
            const Divider(thickness: 1.7,),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact Info", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                  SizedBox(height: 30,),
                  ListTile(
                    leading: Icon(Icons.call, color: Colors.grey.shade800, size: 28,),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("+91 "+widget.contact.phoneNumber.toString()),
                        Text("MOBILE")
                      ],
                    ),
                    trailing: Icon(Icons.message_outlined, color: Colors.grey.shade800,size: 28,),
                    onTap: (){},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  contactDetailSheet(BuildContext context) {
    return showSlidingBottomSheet(context,
        resizeToAvoidBottomInset: true,
        builder: (context) => SlidingSheetDialog(
          isDismissable: true,
          color: Colors.white,
          cornerRadius: 16,
          avoidStatusBar: true,
          snapSpec: const SnapSpec(
            snappings: [0.7],
          ),
          headerBuilder: (context, state) {
            return Container(
              height: 30,
              alignment: Alignment.center,
              child: Container(
                  width: 40, height: 6, color: Colors.grey.shade200),
            );
          },
          builder: (context, state) => Material(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: firstNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct name";
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        prefixIcon: const Icon(Icons.person_outline),
                        hintStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent.shade700,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(fontSize: 10),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red.shade700,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(12, 20, 12, 20),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: lastNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct name";
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Surname',
                        prefixIcon: const Icon(Icons.person_outline),
                        hintStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent.shade700,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(fontSize: 10),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red.shade700,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(12, 20, 12, 20),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: phoneController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                          return "Enter correct phone number";
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone),
                        hintStyle: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black26,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent.shade700,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorMaxLines: 1,
                        errorStyle: const TextStyle(fontSize: 10),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red.shade700,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(12, 20, 12, 20),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  ElevatedButton(onPressed: () async{
                    if(formKey.currentState!.validate()){
                      Contact contact=Contact();
                      contact.firstName = firstNameController.text;
                      contact.surName = lastNameController.text;
                      contact.phoneNumber = phoneController.text;
                      await contactController.updateContact(widget.contact.uid.toString(), contact).then((value){
                        contact.uid= widget.contact.uid;
                        contactController.contactsList.removeWhere((p0) => p0.uid == contact.uid);
                      }).then((value){
                        contactController.contactsList.add(contact);
                        contactController.contactsList.refresh();
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ContactDetails(contact:contact)));
                      });
                    }
                  }, child: Text("Submit")),
                ],
              ),
            ),
          )),
        ));
  }

}
