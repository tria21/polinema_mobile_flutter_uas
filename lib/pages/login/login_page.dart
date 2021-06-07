import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas/database/kategori.dart';
import 'package:uas/database/book.dart';
import 'package:uas/pages/book/dashboard.dart';
import 'package:uas/service/auth.dart';
import 'package:uas/service/auth_email.dart';
import 'package:uas/service/sign_in.dart';
import 'package:uas/pages/login/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  bool _isHidePass = true;
  User user;
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
            "LOGIN LIBRARY APPS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "icons/login.svg",
            height: 150,
          ),
          _form(),
          _loginWithEmail(),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(width: 20),
              Text(
                "OR",
                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          _loginWithGoogle(size, context),
          SizedBox(height: 5),
          _registerButton(context),
        ],
      ),
    ));
  }

Widget _registerButton(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Don’t have account ?",
                  style: TextStyle(color: kPrimaryColor, fontSize: 15),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "Register here",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ],
            ),
            );
  }

  Widget _loginWithGoogle(Size size, BuildContext context) {
    return Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            // ignore: deprecated_member_use
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              color: kPrimaryColor,
              onPressed: () {
                signInWithGoogle().then((result) {
                  if (result != null) {
                    Book.userUid = _auth.currentUser.uid;
                    Kategori.userUid = _auth.currentUser.uid;
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DashboardBookScreen();
                    }));
                  }
                });
              },
              child: Text(
                "Sign in With Google",
                style: TextStyle(color: Colors.white),
              ),
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
                focusNode: _emailFocusNode,
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
              // margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.only(top: 20),
              // width: size.width * 0.8,
              // decoration: BoxDecoration(
              //   color: kPrimaryLightColor,
              //   borderRadius: BorderRadius.circular(29),
              //   border: Border.all(color: kPrimaryColor, width:1),
              // ),
              child: TextFormField(
                controller: _passController,
                focusNode: _passwordFocusNode,
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

  Widget _loginWithEmail() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        // ignore: deprecated_member_use
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: kPrimaryColor,
          onPressed: () async {
            SignInSignUpResult result = await AuthService.signInWithEmail(
                email: _emailController.text, pass: _passController.text);
            if (result.user != null) {
              Book.userUid = _auth.currentUser.uid;
              Kategori.userUid = _auth.currentUser.uid;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new DashboardBookScreen()));
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
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}