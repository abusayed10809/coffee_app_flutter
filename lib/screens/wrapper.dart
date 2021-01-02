import 'package:brew_app/models/user.dart';
import 'package:brew_app/screens/authenticate/authenticate.dart';
import 'package:brew_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  // final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    // provider for using the stream
    final user = Provider.of<userModel>(context);

    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
