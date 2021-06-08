import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas/database/book.dart';

class EditBookForm extends StatefulWidget {
  final FocusNode focusCategory;
  final FocusNode focusTitle;
  final FocusNode focusAuthor;
   final FocusNode focusSinopsis;
  final String currentCategory;
  final String currentTitle;
  final String currentAuthor;
  final String currentSinopsis;
  final String documentId;

  const EditBookForm({
    this.focusCategory,
    this.focusTitle,
    this.focusAuthor,
    this.focusSinopsis,
    this.currentCategory,
    this.currentTitle,
    this.currentAuthor,
    this.currentSinopsis,
    this.documentId,
  });
  @override
  EditBookFormState createState() => EditBookFormState();
  }
  
  class EditBookFormState extends State<EditBookForm> {
    final _editBookKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController sinopsisController = TextEditingController();
  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  @override
  void initState() {
    categoryController =
        TextEditingController(text: widget.currentCategory);
    titleController =
        TextEditingController(text: widget.currentTitle);
    authorController =
        TextEditingController(text: widget.currentAuthor);
    sinopsisController =
        TextEditingController(text: widget.currentSinopsis);
        
    super.initState();
  }
  Widget build(BuildContext context) {
    return Form(
          key: _editBookKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
              padding: EdgeInsets.all(15),
                child:Text(
                  "Edit Data Buku",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
                "icons/add_note.svg",
                height: 150,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kPrimaryColor, width: 1),
                      ),
                      child: TextFormField(
                        controller: categoryController,
                        focusNode: widget.focusCategory,
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5.0, 5.0, 0),
                            labelText: "Category",
                            border: InputBorder.none),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kPrimaryColor, width: 1),
                      ),
                      child: TextFormField(
                        controller: titleController,
                        focusNode: widget.focusTitle,
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5.0, 5.0, 0),
                            labelText: "Title",
                            border: InputBorder.none),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                        maxLines: null,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kPrimaryColor, width: 1),
                      ),
                      child: TextFormField(
                        controller: authorController,
                        focusNode: widget.focusAuthor,
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5.0, 5.0, 0),
                            labelText: "Author",
                            border: InputBorder.none),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                        maxLines: null,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kPrimaryColor, width: 1),
                      ),
                      child: TextFormField(
                        controller: sinopsisController,
                        focusNode: widget.focusSinopsis,
                        keyboardType: TextInputType.text,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 5.0, 5.0, 0),
                            labelText: "Sinopsis",
                            border: InputBorder.none),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please fill this section';
                          }
                          return null;
                        },
                        maxLines: null,
                      ),
                    ),
              
              Container(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: RawMaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text("Edit data",
                            style: TextStyle(
                                color: kPrimaryLightColor, fontSize: 18.0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        elevation: 5.0,
                        fillColor: kPrimaryColor,
                        onPressed: () async {
                          await Book.updateContent(
                            docId: widget.documentId,
                              category: categoryController.text,
                              title: titleController.text,
                              author: authorController.text,
                              sinopsis: sinopsisController.text);
                          
                          Navigator.of(context).pop();
                        }),
                  ))
            ],
          ),
        ),
      ],
    ),
    );
  }
}