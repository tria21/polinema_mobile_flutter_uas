import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas/auth.dart';
import 'package:uas/login_page.dart';
//import 'package:uas/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:uas/first_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>(); //membuat key
  TextEditingController emailController = TextEditingController(); //membuat controller
  TextEditingController passwordController = TextEditingController();
  var authHandler = new Auth(); //membuat auth handler

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  _showTitle(),
                  _formRegister(),
                  _registerButton(),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Already have account ?",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Login here",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _showTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Hello",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Divider(
                  thickness: 3,
                  // color: Colors.white,
                ),
              ),
              SizedBox(width: 40),
            ],
          ),
          // Tulisan Welcome back
          Text(
            "Register First",
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 36, letterSpacing: 5),
          ),
        ],
      ),
    );
  }

//membuat form registrasi
  Widget _formRegister() {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          //form email
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Enter Email",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) { //kondisi untuk inputan email
                return 'Enter an Email Address';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          //form password
          child: TextFormField(
            obscureText: true, //teks disembunyikan
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Enter Password",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) { //kondisi inputan password
                return 'Enter Password';
              } else if (value.length < 6) {
                return 'Password must be atleast 6 characters!'; //password min 6 char
              }
              return null;
            },
          ),
        ),
      ]),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 60),
      child: TextFormField(
        // onSaved: (val) => _email = val,
        validator: (val) => !val.contains("@") ? "Invalid Email" : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "Enter Valid Email",
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: TextFormField(
        // onSaved: (val) => _password = val,
        validator: (val) => val.length < 6 ? "Password Is Too Short" : null,
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Password",
            hintText: "Enter Valid Password",
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
      ),
    );
  }

//membuat register button
  Widget _registerButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          authHandler
              .handleSignUp(emailController.text, passwordController.text) //auth handler pada auth.dart
              .then((User user) {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new FirstScreen()));
          }).catchError((e) => print(e));
        },
        child: Text(
          "Register",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Color(0xff607Cbf),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}
