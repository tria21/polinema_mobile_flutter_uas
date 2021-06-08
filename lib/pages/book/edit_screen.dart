import 'package:flutter/material.dart';
import 'package:uas/pages/form/edit_book.dart';

class EditBookScreen extends StatefulWidget {
  final String currentCategory;
  final String currentTitle;
  final String currentAuthor;
  final String currentSinopsis;
  final String documentId;

  EditBookScreen({
     this.currentCategory,
     this.currentTitle,
    this.currentAuthor,
    this.currentSinopsis,
    this.documentId,
  });

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
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
          title: Text("Edit Buku"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditBookForm(
              documentId: widget.documentId,
              focusCategory: _categoryFocusNode,
              focusTitle: _titleFocusNode,
              focusAuthor: _authorFocusNode,
              focusSinopsis: _sinopsisFocusNode,
              currentCategory: widget.currentCategory,
              currentTitle: widget.currentTitle,
              currentAuthor: widget.currentAuthor,
              currentSinopsis: widget.currentSinopsis,
          
            ),
          ),
        ),
      ),
    );
  }
}