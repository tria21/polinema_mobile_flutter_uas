import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas/database/kategori.dart';
import 'package:uas/database/book.dart';
import 'package:uas/pages/book/dashboard.dart';
import 'package:uas/auth/auth.dart';
import 'package:uas/auth/auth_email.dart';
import 'package:uas/pages/login/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  final _formKey = GlobalKey<FormState>();
  var authHandler = new AuthService();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  bool _isHidePass = true;

  void _togglePasswordvisibility() {
    setState(() {
      _isHidePass = !_isHidePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(40, 60, 40, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "REGISTER LIBRARY APPS",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "icons/register.svg",
              height: 200,
            ),
            _form(),
            _registerButton(),
            _login()
          ],
        ),
      ),
    );
  }

  Widget _form() {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(top: 20),
              // width: size.width * 0.8,
              // decoration: BoxDecoration(
              //   color: kPrimaryLightColor,
              //   borderRadius: BorderRadius.circular(29),
              //   border: Border.all(color: kPrimaryColor, width: 1),
              // ),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.people, color: kPrimaryColor),
                  hintText: "Email",
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter an Email Address';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: _passController,
                obscureText: _isHidePass,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordvisibility();
                    },
                    child: Icon(
                      _isHidePass ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePass ? kPrimaryColor : kPrimaryColor,
                    ),
                  ),
                  isDense: true,
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Password';
                  } else if (value.length < 6) {
                    return 'Password must be atleast 6 characters!';
                  }
                  return null;
                },
              ),
            ),
          ],
        ));
  }

  Widget _registerButton() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: RaisedButton(
          onPressed: () async {
            SignInSignUpResult result = await AuthService.createUser(
                email: _emailController.text, pass: _passController.text);
            if (result.user != null) {
              Book.userUid = _auth.currentUser.uid;
              Kategori.userUid = _auth.currentUser.uid;
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DashboardBookScreen()));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(result.message),
                          actions: <Widget>[
                            // ignore: deprecated_member_use
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"))
                          ]));
            }
          },
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Color(0xff607Cbf),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 16),
        ),
      //),
    );
  }

  Widget _login() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Have account ?",
            style: TextStyle(color: kPrimaryColor, fontSize: 16),
          ),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              "Login Here",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}