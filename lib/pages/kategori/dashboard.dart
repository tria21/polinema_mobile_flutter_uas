import 'package:flutter/material.dart';
import 'package:uas/drawer/drawer.dart';
import 'package:uas/pages/list/kategori_list.dart';
import 'package:uas/pages/kategori/add_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff607Cbf),
          title: Text("Kategori"),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(),
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
          child: CategoryList(),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}