import 'package:contacts/Controllers/UserController.dart';
import 'package:contacts/Screens/ContactsScreen.dart';
import 'package:contacts/Screens/homeScreen.dart';
import 'package:contacts/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late User? currUser;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  currUser = FirebaseAuth.instance.currentUser;
  if (currUser != null) {
    await userProfileService.getProfile(currUser?.uid);
  }

  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user != null) {
      currUser = user;
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (currUser == null)?HomeScreen():ContactScreen(),
    );
  }
}
