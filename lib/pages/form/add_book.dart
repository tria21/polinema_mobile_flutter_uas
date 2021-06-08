import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas/database/kategori.dart';
import 'package:uas/database/book.dart';

class AddBookForm extends StatefulWidget {
  FocusNode focusCategory = FocusNode();
  FocusNode focusTitle = FocusNode();
  FocusNode focusAuthor = FocusNode();
  FocusNode focusSinopsis = FocusNode();

  AddBookForm(
      {this.focusCategory,
      this.focusTitle,
      this.focusAuthor,
      this.focusSinopsis});
  @override
  AddBookFormState createState() => AddBookFormState();
}

class AddBookFormState extends State<AddBookForm> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController sinopsisController = TextEditingController();

  var pilihKategori;

  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  final _formBookKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Form(
      key: _formBookKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Tambah Data Buku",
            textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25.0),
            ),
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Kategori.readItems(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          const Text("Loading ...");
                        } else {
                          List<DropdownMenuItem> currencyCategorys = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            var snap = snapshot.data.docs[i].data();
                            //String docId = snapshot.data.docs[i].id;
                            String name = snap['namaKategori'];
                            currencyCategorys.add(DropdownMenuItem(
                              child: Text(name),
                              value: "${name}",
                            ));
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              DropdownButton(
                                focusNode: widget.focusCategory,
                                items: currencyCategorys,
                                onChanged: (currencyValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Kategori Yang Dipilih $currencyValue',
                                      style:
                                          TextStyle(color: kPrimaryLightColor),
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    pilihKategori = currencyValue;
                                  });
                                },
                                value: pilihKategori,
                                isExpanded: false,
                                hint: new Text(
                                  "Pilih Kategori Buku",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    )),
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
                    maxLines: 1,
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
                          child: Text("Add data",
                              style: TextStyle(
                                  color: kPrimaryLightColor, fontSize: 18.0)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 5.0,
                          fillColor: Color(0xff607Cbf),
                          onPressed: () async {
                            await Book.addContent(
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
