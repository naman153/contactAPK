import 'dart:async';

import 'package:contacts/Controllers/ContactController.dart';
import 'package:contacts/Screens/ContactsScreen.dart';
import 'package:contacts/services/UserAuthServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/permissionController.dart';

TextEditingController emailId = TextEditingController();
TextEditingController password = TextEditingController();

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  var _isResumed = false.obs;

  @override
  void initState() {
    checkNotification();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('Activated again ${state}');
    if (state == AppLifecycleState.resumed) {
      _isResumed.value = true;
      // _isResumed.refresh();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  checkNotification() async {
    var settings = await permissionController.requestAllPermissions();
    StreamSubscription<bool>? _listener;
    if (settings == false) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('🔔 Permissions for contacts!'),
          content: Text(
            'We strongly recommend you to enable all the permissions and a better user experience!',
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await permissionController.requestPermission(true, null);
                _listener = _isResumed.listen((p0) async {
                  if (_isResumed.value) {
                    var settings =
                    await permissionController.requestAllPermissions();
                    if (settings == true) {
                      Navigator.of(context).pop();
                    }
                  }
                });
              },
              child: Text('Open Settings'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.6,
              width: MediaQuery.of(context).size.width-10,
              child: Image.asset("assets/images/contact_logo.jpg"),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.34,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: Colors.lightBlueAccent.withOpacity(0.2)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Sign In", style: TextStyle(fontSize: 24),),
                  Spacer(),
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.90, 30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          width: 14,
                          height: 14,
                          image: AssetImage('assets/images/google.webp'),
                        ),
                        Text('\t\tSign in with Google',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(color: Colors.black54))
                      ],
                    ),
                    onPressed: () async {
                        await userAuthentication.signInWithGoogle().then((res) async {
                          if(userAuthentication.isLoggedIn==true){
                            await contactController.getContacts();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ContactScreen()), (route) => false);
                          }
                        });
                    },
                  ),
                  Spacer(),
                ],
              ),

            )
          ],
        ),
      ),
    ));
  }
}
