import 'package:flutter/material.dart';
import 'package:uas/pages/form/add_book.dart';

class AddBookScreen extends StatelessWidget {
  final FocusNode _categoryFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _authorFocusNode = FocusNode();
  final FocusNode _sinopsisFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _categoryFocusNode.unfocus();
        _titleFocusNode.unfocus();
        _authorFocusNode.unfocus();
        _sinopsisFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff607Cbf),
          title: Text("Tambah Buku"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddBookForm(
              focusCategory: _categoryFocusNode,
              focusTitle: _titleFocusNode,
              focusAuthor: _authorFocusNode,
              focusSinopsis: _sinopsisFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}