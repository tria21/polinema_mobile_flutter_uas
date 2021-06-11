import 'package:flutter/material.dart';
import 'package:uas/contoh_sederhana/kategori_page.dart';
import 'package:uas/contoh_sederhana/book_page.dart';
import 'package:uas/pages/form/add_book.dart';
import 'package:uas/pages/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas/pages/kategori/dashboard.dart';
import 'package:uas/pages/book/dashboard.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library Apps',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/buku': (context) => DashboardBookScreen(),
        '/kategori': (context) => DashboardScreen(),
      },
    );
  }
}