import 'package:uas/auth.dart';
//import 'package:uas/profil_page.dart';
import 'package:uas/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas/sign_in.dart';
//import 'package:uas/first_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); //membuat key
  TextEditingController emailController = TextEditingController(); //membuat controller
  TextEditingController passwordController = TextEditingController();
  var authHandler = new Auth(); //membuat authHandler                                                                                                          

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
                  _formLogin(),
                  _loginButton(),
                  _textOr(),
                  _signInButton(),
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
                        "Don’t have account ?",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          "Register here",
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
                child: Divider( //membuat garis
                  thickness: 3,
                  // color: Colors.white,
                ),
              ),
              SizedBox(width: 40),
            ],
          ),
          // Tulisan Welcome back
          Text(
            "Welcome back",
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 36, letterSpacing: 5),
          ),
        ],
      ),
    );
  }

//membuat form untuk login
  Widget _formLogin() {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          //membuuat form email
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Enter Email",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) { //kondisi ketika memasukkan email
              if (value.isEmpty) {
                return 'Enter an Email Address';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email address'; //email harus menggunakan @
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          //membuat form password
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Enter Password",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) { //kondisi ketika input password
                return 'Enter Password';
              } else if (value.length < 6) {
                return 'Password must be atleast 6 characters!'; //password min 6 karakter
              }
              return null;
            },
          ),
        ),
      ]),
    );
  }

//memastikan inputan email
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

//memastikan inputan password
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

//membuat button untuk login
  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          authHandler //auth pada auth.dart
              .handleSignInEmail(emailController.text, passwordController.text)
              .then((User user) {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new EmailPage()));
          }).catchError((e) => print(e));
        },
        child: Text(
          "Login",
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

//menampilkan teks or
  Widget _textOr() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 1,
          ),
        ),
        SizedBox(width: 20),
        Text(
          "OR",
          // style: TextStyle(color: Colors.white),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Divider( //menampilkan garis
            thickness: 1,
          ),
        ),
      ],
    );
  }

//membuat button sign in
  Widget _signInButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          signInWithGoogle().then((result) { //auth pada sign_in.dart
            if (result != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FirstScreen();
                  },
                ),
              );
            }
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: NetworkImage( //menampilkan gambar google
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png'),
                  height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
