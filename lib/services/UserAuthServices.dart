import 'package:contacts/Controllers/UserController.dart';
import 'package:contacts/Models/UserProfile.dart';
import 'package:contacts/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthentication{

  bool isLoggedIn= false;

  signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await fetchUser(credential);
    } catch (e) {
      throw (e);
    }
  }

}
UserAuthentication userAuthentication= UserAuthentication();

fetchUser(AuthCredential authCredential) async{
  try {
    await FirebaseAuth.instance.signInWithCredential(authCredential);
    userAuthentication.isLoggedIn = true;
    currUser = FirebaseAuth.instance.currentUser;
    await createUserProfileData();
  } on FirebaseAuthException catch(e){
    if(e.code == 'session-expired'){
      print(e.code);
    }
  }
}

createUserProfileData() async {
  await userProfileService.getProfile(currUser?.uid);
  //print("creating profile.............");
  // creating new user profile
  if (currUser != null && userProfileService.profileOfUser == null) {
    print("User data does not exists. Creating new data.!");
    UserProfile newUser = UserProfile();
    newUser.firstName = currUser?.displayName ?? "";
    newUser.uid = currUser?.uid ?? '';
    newUser.emailId = currUser?.email ?? "";
    // print(newUser.toMap());
    userProfileService.profileOfUser = newUser;
    await userProfileService.updateProfile(1);
    return 1;
  } else {
    print('user Data Exists Will not update data: ' +
        userProfileService.profileOfUser!.emailId!);
  }
}