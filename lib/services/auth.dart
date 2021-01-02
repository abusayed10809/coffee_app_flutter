import 'dart:async';

import 'package:brew_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService{

  final FirebaseAuth _auth  = FirebaseAuth.instance;

  // creating user object from firebase user
  // returns the user id for a firebase user type user
  userModel _userFirebaseUser(User user){
    return user != null ? userModel(uid: user.uid) : null;
  }

  // net ninja *****
  // listening to auth changes in the stream
  // getter of type user, to know when the authstate changes of the current user
  // mapping the user in the firebase model, it'll return the userid
  Stream<userModel> get user {
    return _auth.authStateChanges().map((User user) => _userFirebaseUser(user));
  }

  // anonymous sign in
  Future signInAnonymous() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFirebaseUser(user);
    }
    catch(e) {

    }
  }

  // sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      // complete signin with email and password
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // getting the user info from result user
      User user = result.user;
      // returning the user id of that user when it is signed in
      return _userFirebaseUser(user);
    }
    catch(e){
      return null;
    }
  }

  // register with email and pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFirebaseUser(user);
    }
    catch(e){
      return null;
    }
  }

  // sign out
  Future signingOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}