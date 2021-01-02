import 'dart:async';

import 'package:brew_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          'Coffee Mates',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0.0,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
            'Check your email and verify account to proceed.',
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async{
    user = auth.currentUser;
    await user.reload();

    if(user.emailVerified){
      timer.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
