import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas/database/kategori.dart';

class EditCategoryForm extends StatefulWidget {
  final FocusNode focusNamaKategori;
  final FocusNode focusDescription;
  final String currentNamaKategori;
  final String currentDescription;
  final String documentId;

  const EditCategoryForm({
    this.focusNamaKategori,
    this.focusDescription,
    this.currentNamaKategori,
    this.currentDescription,
    this.documentId,
  });
  @override
  EditCategoryFormState createState() => EditCategoryFormState();
}

class EditCategoryFormState extends State<EditCategoryForm> {
  final _editCategoryKey = GlobalKey<FormState>();
  TextEditingController namaKategoriController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  @override
  void initState() {
    namaKategoriController =
        TextEditingController(text: widget.currentNamaKategori);
    descriptionController =
        TextEditingController(text: widget.currentDescription);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Form(
      key: _editCategoryKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
                height: 10,
              ),
              Container(
                child:Text(
                  "Edit Data Kategori",
                  style: TextStyle(fontSize: 25.0),
                ),
                margin: EdgeInsets.all(15),
              ),
          SizedBox(
            height: 30,
          ),
          SvgPicture.asset(
            "icons/add_category.svg",
            height: 200,
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
                    controller: namaKategoriController,
                    focusNode: widget.focusNamaKategori,
                    keyboardType: TextInputType.text,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 5.0, 5.0, 0),
                        labelText: "Category Name",
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
                    controller: descriptionController,
                    focusNode: widget.focusDescription,
                    keyboardType: TextInputType.text,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 5.0, 5.0, 0),
                        labelText: "Description",
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
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: RawMaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("Update data",
                        style: TextStyle(
                            color: kPrimaryLightColor, fontSize: 18.0)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    elevation: 5.0,
                    fillColor: kPrimaryColor,
                    onPressed: () async {
                      await Kategori.updateItem(
                          docId: widget.documentId,
                          namaKategori: namaKategoriController.text,
                          description: descriptionController.text);
                      Navigator.of(context).pop();
                    }),
              ))
        ],
      ),
    );
  }
}