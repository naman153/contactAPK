import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/Models/UserProfile.dart';
import 'package:contacts/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserProfileService extends GetxController {
  final db = FirebaseFirestore.instance;
  UserProfile? profileOfUser;

  updateProfile(int isNewUser) async {
    try {
      if (userProfileService.profileOfUser != null) {
        userProfileService.profileOfUser!.uid =
            FirebaseAuth.instance.currentUser!.uid;
        if (isNewUser == 1) {
          await db
              .collection("users")
              .doc(userProfileService.profileOfUser?.uid ?? currUser?.uid)
              .set(userProfileService.profileOfUser!.toMap())
              .then((value) => print("Successfully updated profile of user"));
        } else {
          await db
              .collection("users")
              .doc(userProfileService.profileOfUser?.uid ?? currUser?.uid)
              .set(userProfileService.profileOfUser!.toMap())
              .then((value) => print("Successfully updated profile of user"));
        }
        await getProfile(FirebaseAuth.instance.currentUser?.uid);
      }
    } catch (e) {
      print('UpdateProfileException : ' + e.toString());
      throw (e);
    }
  }

  getProfile(String? uId) async {
    try {
      final ref = db.collection("users").doc(uId);
      var docSnap = await ref.get();
      if (docSnap.exists) {
        var data = docSnap.data();
        profileOfUser = UserProfile.fromJson(data!);
        print(profileOfUser);
        print("UID:" + profileOfUser!.uid);
      } else {
        profileOfUser = null;
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}

UserProfileService userProfileService = UserProfileService();