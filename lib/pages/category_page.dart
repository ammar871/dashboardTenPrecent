import 'dart:io';

import 'package:dashboard_web/pojo/category.dart';
import 'package:dashboard_web/providers/provider_addCategory.dart';

import 'package:dashboard_web/providers/provider_category.dart';

import 'package:dashboard_web/widget/title_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late ProviderCategory dataprovider;
  late ProviderAddCategory providerAdd;
  late List<Data> list;

  getData(BuildContext context) async {
    dataprovider = Provider.of(context);
    providerAdd = Provider.of(context);
    providerAdd.loading = false;
    dataprovider.loading = true;
    dataprovider.categoryData("1");
    list = dataprovider.list;
    print(dataprovider.list.length);
  }

  final _formKey = GlobalKey<FormState>();
  late File _image;

  final _imagePicker = ImagePicker();
  String selctedImag = "No Selected Image";

  @override
  void initState() {
    super.initState();
    // getData(context).whenComplete(() {
    //   setState(() {});
    // });
  }


  @override
  Widget build(BuildContext context) {
    getData(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 45,
              width: 200,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.blue,
                splashColor: Colors.white,
                textColor: Colors.white,
                elevation: 2,
                animationDuration: Duration(seconds: 5),
                hoverColor: Colors.black.withOpacity(0.6),
                onPressed: () {
                  showDialogAddCtaegory(context);
                },
                child: Center(
                  child: Text(
                    "اضافة قسم",
                    style: TextStyle(
                        fontFamily: 'fonttwo',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TitlesTable(),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                width: 90,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: MaterialButton(
                                    hoverColor: Colors.black.withOpacity(0.6),
                                    color: Color(0xFFC82333),
                                    onPressed: () {
                                      showDialogDelete(context,index);
                                    },
                                    child: Text(
                                      "حذف",
                                      style: TextStyle(
                                          fontFamily: 'Schyler',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                )),
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                width: 90,
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: MaterialButton(
                                    hoverColor: Colors.black.withOpacity(0.6),
                                    color: Color(0xFF0069D9),
                                    onPressed: () {

                                      showDialogEditeCategory(context, index);



                                    },
                                    child: Text(
                                      "تعديل",
                                      style: TextStyle(
                                          fontFamily: 'Schyler',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                )),
                            Container(
                              width: 150,
                              height: 60,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 0.5)),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: list[index].image,
                                  placeholder: (context, url) => Icon(
                                    Icons.photo_sharp,
                                    color: Colors.black12,
                                    size: 55,
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.photo_sharp,
                                    color: Colors.black12,
                                    size: 55,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey, width: 0.5)),
                                    child: Center(
                                      child: Text(
                                        list[index].name,
                                        style: TextStyle(
                                            fontFamily: 'fonttwo',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                    ))),
                            Container(
                              width: 50,
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 0.5)),
                              child: Center(
                                child: Text(
                                  list[index].id.toString(),
                                  style: TextStyle(
                                      fontFamily: 'fonttwo',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ));
                  }),
            )
          ],
        ),
      ),
    );
  }

  void showDialogEditeCategory(BuildContext context, int index) {
     showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            _editController.text=list[index].name;
            return AlertDialog(

              actions: <Widget>[
                Form(
                  key: _formKey,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Colors.white,
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _isPicked = false;
                                        _editController.text = "";
                                      },
                                      icon: Icon(Icons.close)),
                                  Text(
                                    "تعديل القسم  ",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "اسم القسم ",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'أدخل الاسم ..';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    name = value!;
                                  },
                                  textAlign: TextAlign.right,
                                  controller: _editController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                      ),
                                      hintText: "اكتب الاسم",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'bold',
                                      )),
                                )),
                            // DialogTextField("الاسم", _editController, _validate),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "الصــورة",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _isPicked
                                        ? "Selected Image"
                                        : "No selected Image",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  MaterialButton(
                                    color: Color(0xFF0069D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                    onPressed: () {
                                      getImage().whenComplete(() {
                                        setState(() {

                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 90,
                                      child: Center(
                                        child: Text(
                                          "Choose Fill",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Divider(
                              height: 0.5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    color: Color(0xFF0069D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'من فضلك أدخل اسم القسم ..',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (!_isPicked) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "اختار الصورة",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }


                                      else {
                                        providerAdd.uploadSelectedFile(
                                            _image.path, _editController.text);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "تم الحفظ ..",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          "تعديل",
                                          style: TextStyle(
                                              fontFamily: 'home',
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  MaterialButton(
                                    color: Colors.black.withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                    onPressed: () {},
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          "إغلاق",
                                          style: TextStyle(
                                              fontFamily: 'home',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }


  bool _isPicked = false;

  Future getImage() async {
    final pickFill = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickFill != null) {
        _image = File(pickFill.path);
        setState(() {
          _isPicked = true;
        });
      } else {
        setState(() {
          _isPicked = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  final _editController = TextEditingController();
  String name = "";

  void showDialogAddCtaegory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(

              actions: <Widget>[
                Form(
                  key: _formKey,
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Colors.white,
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _isPicked = false;
                                        _editController.text = "";
                                      },
                                      icon: Icon(Icons.close)),
                                  Text(
                                    "اضافة قسم ",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "اسم القسم ",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'أدخل الاسم ..';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    name = value!;
                                  },
                                  textAlign: TextAlign.right,
                                  controller: _editController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 5,
                                          bottom: 5),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.blue,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                      ),
                                      hintText: "اكتب الاسم",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'bold',
                                      )),
                                )),
                            // DialogTextField("الاسم", _editController, _validate),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "الصــورة",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _isPicked
                                        ? "Selected Image"
                                        : "No selected Image",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  MaterialButton(
                                    color: Color(0xFF0069D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                    onPressed: () {
                                      getImage().whenComplete(() {
                                        setState(() {

                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 90,
                                      child: Center(
                                        child: Text(
                                          "Choose Fill",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Divider(
                              height: 0.5,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    color: Color(0xFF0069D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                    onPressed: () {
                                      if (!_formKey.currentState!.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'من فضلك أدخل اسم القسم ..',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else if (!_isPicked) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "اختار الصورة",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }


                                      else {
                                        providerAdd.uploadSelectedFile(
                                            _image.path, _editController.text);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "تم الحفظ ..",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          providerAdd.loading
                                              ? "جارى التحميل"
                                              : "حفظ",
                                          style: TextStyle(
                                              fontFamily: 'home',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  MaterialButton(
                                    color: Colors.black.withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5.0)),
                                    onPressed: () {},
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Center(
                                        child: Text(
                                          "إغلاق",
                                          style: TextStyle(
                                              fontFamily: 'home',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
  void showDialogDelete(BuildContext context,int index) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "هل أنت متـأكد من أنك تريد الحذف ؟",
                          textAlign: TextAlign.right,
                          maxLines: 3,
                          style: TextStyle(
                              fontFamily: 'home',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialButton(
                              color: Color(0xFF0069D9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                setState(() {
                                  dataprovider.categoryDeleting(list[index].id);
                                  if(dataprovider.loadingDelete){

                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "تم الحذف بنجاح  ..",
                                          style: TextStyle(
                                            fontSize: 20,
                                              fontFamily: "bold",
                                              color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }else{
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "فشلت العملية. ..",
                                          style: TextStyle(
                                            fontSize: 20,
                                              fontFamily: "bold",
                                              color: Colors.white),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }

                                });

                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "نعم",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            MaterialButton(
                              color: Colors.black.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "لا",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class ItemListView extends StatelessWidget {
  final List<Data> list;
  final int index;

  ItemListView(this.list, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5.0),
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: MaterialButton(
                    hoverColor: Colors.black.withOpacity(0.6),
                    color: Color(0xFFC82333),
                    onPressed: () {
                      showDialogDelete(context);
                    },
                    child: Text(
                      "حذف",
                      style: TextStyle(
                          fontFamily: 'Schyler',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(5.0),
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: MaterialButton(
                    hoverColor: Colors.black.withOpacity(0.6),
                    color: Color(0xFF0069D9),
                    onPressed: () {





                    },
                    child: Text(
                      "تعديل",
                      style: TextStyle(
                          fontFamily: 'Schyler',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                )),
            Container(
              width: 150,
              height: 60,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: list[index].image,
                  placeholder: (context, url) => Icon(
                    Icons.photo_sharp,
                    color: Colors.black12,
                    size: 55,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.photo_sharp,
                    color: Colors.black12,
                    size: 55,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    child: Center(
                      child: Text(
                        list[index].name,
                        style: TextStyle(
                            fontFamily: 'fonttwo',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ))),
            Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5)),
              child: Center(
                child: Text(
                  list[index].id.toString(),
                  style: TextStyle(
                      fontFamily: 'fonttwo',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ));
  }

  void showDialogDelete(BuildContext context) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "هل أنت متـأكد من أنك تريد الحذف ؟",
                          textAlign: TextAlign.right,
                          maxLines: 3,
                          style: TextStyle(
                              fontFamily: 'home',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialButton(
                              color: Color(0xFF0069D9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {},
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "نعم",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            MaterialButton(
                              color: Colors.black.withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: Text(
                                    "لا",
                                    style: TextStyle(
                                        fontFamily: 'home',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
