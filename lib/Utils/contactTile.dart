import 'package:contacts/Models/Contacts.dart';
import 'package:contacts/Screens/contactDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ContactTile(Contact contactDetails, BuildContext context){
  return ListTile(
    leading: CircleAvatar(
      radius: 20,
      child: Text(contactDetails.firstName![0].toUpperCase()),
    ),
    title: Text(contactDetails.firstName! +" "+ contactDetails.surName!, textAlign: TextAlign.start,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactDetails(contact: contactDetails,)));
    },
  );
}