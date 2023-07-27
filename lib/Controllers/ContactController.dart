import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/Models/Contacts.dart';
import 'package:contacts/main.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';

class ContactController{
  final db = FirebaseFirestore.instance;
  var contactsList= <ContactModel>[].obs;
  
  getContacts() async {
    try{
     await db.collection("users/${currUser!.uid}/contacts").get().then((contacts)async{
        List<ContactModel> tempContactList=[];
        await Future.forEach(contacts.docs, (contact) {
          ContactModel tempContact=ContactModel.fromJson(contact.data());
          tempContact.uid= contact.id;
          tempContactList.add(tempContact);
        });
        contactsList.value = tempContactList;
        contactsList.refresh();
      });
    }catch(e){
      print("Error in fetching contacts.");
    }
  }

  updateContact(String uid, ContactModel updatedContact) async {
    try{
      await db.collection("users/${currUser!.uid}/contacts").doc(uid).update(
        updatedContact.toMap()).whenComplete((){
          print("Updation Completed");
      });
    }catch(e){
      print("Error in updating contacts.");
    }
  }

  deleteContact(String uid) async {
    try{
      await db.collection("users/${currUser!.uid}/contacts").doc(uid).delete().whenComplete((){
        print("Deletion Completed");
      });
    }catch(e){
      print("Error in deleting contacts.");
    }
  }

  saveContact(ContactModel contactDetails)async{
    try{
      await db.collection("users/${currUser!.uid}/contacts").doc(contactDetails.phoneNumber).set(contactDetails.toMap()).whenComplete(() async {
        print("Saving Completed");
        contactsList.add(contactDetails);
        contactsList.refresh();
      });
    }catch(e){
      print("Error in saving contacts.");
    }
  }

  getDeviceContacts() async {
    try{
      await ContactsService.getContacts(withThumbnails: false)
          .then((contacts) async {
        await Future.forEach(contacts, (contact) async {
          ContactModel tempContact = ContactModel();
          tempContact.firstName = contact.givenName;
          tempContact.surName = contact.familyName;
          tempContact.phoneNumber = contact.phones!.first.value!.substring(3);
          await saveContact(tempContact);
        });
      });
      await getContacts();
      Future.delayed(Duration(minutes: 10)).then((value) => getDeviceContacts());
    }catch(e){
      print("ERRORCaught getDeviceContacts");
    }
  }
}
ContactController contactController= ContactController();