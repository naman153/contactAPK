import 'package:contacts/Controllers/ContactController.dart';
import 'package:contacts/Models/Contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts/Utils/contactTile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  
  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    contactController.getContacts();
    contactController.getDeviceContacts();
    firstNameController.text='';
    lastNameController.text='';
    phoneController.text='';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Contacts", style: TextStyle(fontSize: 30),),
            Obx(() => (contactController.contactsList.length.isGreaterThan(0))?
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 2, right: 2, bottom: 85, top: 2),
                itemCount: contactController.contactsList.length,
                itemBuilder: (context,index){
                  return ContactTile(contactController.contactsList[index], context);
                })
                :Center(child: Icon(Icons.no_accounts_rounded, size: 100,),))



          ],),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const CircleBorder(),),
        onPressed: (){
          contactDetailSheet(context);
        },
        child: const Text("+", style: TextStyle(fontSize: 30),),
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
                      ContactModel contact=ContactModel();
                      contact.firstName = firstNameController.text;
                      contact.surName = lastNameController.text;
                      contact.phoneNumber = phoneController.text;
                      await contactController.saveContact(contact).then((value){
                        Navigator.pop(context);
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
