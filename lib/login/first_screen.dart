import 'package:uas/kategori_page.dart';
import 'package:uas/book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'), //title pada appbar
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 120,
            margin: EdgeInsets.only(top: 300, right: 10),
            child: RaisedButton(
              color: Colors.red[300],
              child: Text("Book", style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookPage()),
                );
              },
            ),
          ),
          Container(
            height: 60,
            width: 120,
            margin: EdgeInsets.only(top: 300, left: 10),
            child: RaisedButton(
              color: Colors.red[300],
              child: Text("Kategori", style: TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KategoriPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}