import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/Models/Contacts.dart';
import 'package:contacts/main.dart';
import 'package:get/get.dart';

class ContactController{
  final db = FirebaseFirestore.instance;
  var contactsList= <Contact>[].obs;
  
  getContacts() async {
    try{
     await db.collection("users/${currUser!.uid}/contacts").get().then((contacts)async{
        List<Contact> tempContactList=[];
        await Future.forEach(contacts.docs, (contact) {
          Contact tempContact=Contact.fromJson(contact.data());
          tempContact.uid= contact.id;
          tempContactList.add(tempContact);
        });
        contactsList.value = tempContactList;
      });
    }catch(e){
      print("Error in fetching contacts.");
    }
  }

  updateContact(String uid, Contact updatedContact) async {
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

  saveContact(Contact contactDetails)async{
    try{
      await db.collection("users/${currUser!.uid}/contacts").add(contactDetails.toMap()).whenComplete(() async {
        print("Saving Completed");
        await getContacts();
      });
    }catch(e){
      print("Error in saving contacts.");
    }
  }
}
ContactController contactController= ContactController();