import 'package:flutter/material.dart';
import 'package:uas/pages/form/add_category.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _categoryNameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _categoryNameFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("Category List"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddCategoryForm(
              focusNamaKategori: _categoryNameFocusNode,
              focusDescription: _descriptionFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}