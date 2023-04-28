import 'dart:core';

class UserProfile {
  String? firstName;
  String? surName;
  late String uid;
  String? emailId;
  UserProfile();

  UserProfile.fromJson(Map<String, dynamic> json) {
    firstName = json['name']?.split(" ").first;
    surName =
    json['name'] != null ? json['name'].split(" ").last : json['name'];
    uid = json['uid'];
    emailId = json['emailId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': firstName,
      'surName': firstName?.split(" ").last,
      'uid': uid,
      'emailId': emailId,
    };
  }
}