import 'package:flutter/material.dart';
import 'package:uas/drawer/drawer.dart';
import 'package:uas/pages/list/book_list.dart';
import 'package:uas/pages/book/add_screen.dart';

class DashboardBookScreen extends StatefulWidget {
  @override
  _DashboardBookScreenState createState() => _DashboardBookScreenState();
}

class _DashboardBookScreenState extends State<DashboardBookScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff607Cbf),
          title: Text("Buku"),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddBookScreen(),
            ),
          );
        },
        backgroundColor: Color(0xff607Cbf),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 10.0,
          ),
          child: BookList(),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}