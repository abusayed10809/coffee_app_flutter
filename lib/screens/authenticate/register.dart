import 'package:brew_app/screens/authenticate/verify.dart';
import 'package:brew_app/services/auth.dart';
import 'package:brew_app/shared/constants.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final FirebaseAuth emailAuth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0.0,
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Login'),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Email...'),
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.length < 6 ? 'Password must have 6 characters minimum' : null,
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'Password...'),
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 40.0),
              Container(
                width: 200.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Colors.yellow,
                  child: Text(
                    'Register',
                  ),
                  onPressed: () async {
                    // if the form has vaild inputs
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Please enter valid form inputs';
                          loading = false;
                        });
                      }
                      // emailAuth.createUserWithEmailAndPassword(email: email, password: password).then((_) {
                      //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Verify()));
                      // }).catchError((_){
                      //   setState(() {
                      //     error = 'Please enter valid form inputs.';
                      //     loading = false;
                      //   });
                      // });
                    }
                  },
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
