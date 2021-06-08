import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uas/service/sign_in.dart';
import 'package:uas/pages/login/login_page.dart';

class MainDrawer extends StatelessWidget {
   MainDrawer({
    Key key,
  }) : super(key: key);

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.only(top: 50), 
        children: <Widget>[
       ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.account_circle, color: Colors.white),
          backgroundColor: Colors.black),
        title: Text("Library Apps"),
        subtitle: Text(_auth.currentUser.email),
      ),
      ListTile(
          leading: Icon(Icons.library_books_rounded),
          title: Text("Buku"),
          onTap: () {
             Navigator.pushNamed(context, '/home');
          }),
      ListTile(
        leading: Icon(Icons.category_outlined),
        title: Text("Kategori"),
        onTap: () {
           Navigator.pushNamed(context, '/kategori');
        },
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text("Logout"),
        onTap: () {
          signOutGoogle();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return LoginPage();
          }), ModalRoute.withName('/'));
        },
      )
    ]));
  }
}