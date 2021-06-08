import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas/database/kategori.dart';

class AddCategoryForm extends StatefulWidget {
   FocusNode focusNamaKategori = FocusNode();
   FocusNode focusDescription = FocusNode();

   AddCategoryForm({
    this.focusNamaKategori,
    this.focusDescription,
  });

  @override
  AddCategoryFormState createState() => AddCategoryFormState();
}

class AddCategoryFormState extends State<AddCategoryForm> {
  final TextEditingController namaKategoriController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final kPrimaryColor = Colors.black;
  final kPrimaryLightColor = Colors.white;
  final _formCategoryKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  return  Form(
          key: _formCategoryKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
              padding: EdgeInsets.all(15),
                child:Text(
                  "Tambah Data Kategori",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              SizedBox(height: 30,),
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
                            labelText: "Nama Kategori Buku",
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
                            labelText: "Deskripsi Kategori",
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
              SizedBox(height: 60,),
              Container(
                padding: EdgeInsets.all(20),
                  child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: RawMaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("Tambah Data",
                        style: TextStyle(
                            color: kPrimaryLightColor, fontSize: 18.0)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 5.0,
                    fillColor: Color(0xff607Cbf),
                    onPressed: ()async{
                      await Kategori.addItem(
                        namaKategori : namaKategoriController.text,
                        description: descriptionController.text
                      );
                      Navigator.of(context).pop();
                    }),
              ))
            ],
          ),
        );
  }
}