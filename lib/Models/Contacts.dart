import 'dart:core';

class Contact {
  String? firstName;
  String? surName;
  String? phoneNumber;
  String? uid;
  Contact();

  Contact.fromJson(Map<String, dynamic> json) {
    firstName = json['name'];
    surName =
    json['name'] != null ? json['surName']:"";
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': firstName,
      'surName': surName,
      'phoneNumber': phoneNumber,
    };
  }
}