
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_web/pojo/products_model.dart';
import 'package:dashboard_web/providers/products_provider.dart';
import 'package:dashboard_web/widget/dialog_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int count = 0;
  String dropdownValue = 'One';

  List<String> spinnerItems = ['One', 'Two', 'Three', 'Four', 'Five'];
  late ProviderProducts _providerProducts;

  late List<DataProduct> list;
  bool loading = false;
late File _image;

  getData() async {
    list = [];
    _providerProducts = Provider.of(context);

    _providerProducts.getProductsData("1");
    list = _providerProducts.list;

    print(_providerProducts.loading);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            SizedBox(
              height: 30,
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
                  showDialogAddProduct(context);
                },
                child: Center(
                  child: Text(
                    "اضافة منتج",
                    style: TextStyle(
                        fontFamily: 'fonttwo',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            _providerProducts.loading
                ? Padding(
                    padding: const EdgeInsets.only(top: 500),
                    child: Center(
                      child: SpinKitRing(
                        color: Colors.blue,
                        size: 30,
                        duration: Duration(milliseconds: 700),
                        lineWidth: 5,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1+ list.length,
                    itemBuilder: (BuildContext ctx, index) {
                   if(index==0){
                     return TitleTable();
                   }
                      DataProduct dataProduct=list[index -1];
                      return ItemListProduct(dataProduct,  index);
                    })
          ]),
        ],
      ),
    );
  }




  final _formKey = GlobalKey<FormState>();

  final _imagePicker = ImagePicker();
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

  String selctedImag = "No Selected Image";

  final _editControllerName = TextEditingController();
  final _editControllerDesc = TextEditingController();
  final _editControllerPrice = TextEditingController();
  final _editControllerDiscount = TextEditingController();

  void showDialogAddProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ListView(
              children: [
                Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Form(
                      key: _formKey,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(Icons.close)),
                                    Text(
                                      "اضافة منتـج ",
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
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 8),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "اختار القسم",
                                              style: TextStyle(
                                                  fontFamily: 'home',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      Colors.black.withOpacity(.5)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Center(
                                                      child: DropdownButton<String>(
                                                        underline: SizedBox(),
                                                        value: dropdownValue,
                                                        icon: Icon(Icons
                                                            .keyboard_arrow_down_sharp),
                                                        iconSize: 24,
                                                        isExpanded: true,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15),
                                                        onChanged: (data) {
                                                          dropdownValue = data!;
                                                          setState(() {});
                                                        },
                                                        items: spinnerItems.map<
                                                                DropdownMenuItem<
                                                                    String>>(
                                                            (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    )),
                                  ),
                                  Expanded(
                                    child: CustomFieldProducte("اسم المنتج",
                                        "أدخل اسم المنتج ", _editControllerName),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 8),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "اختار الصــورة",
                                              style: TextStyle(
                                                  fontFamily: 'home',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      Colors.black.withOpacity(.5)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
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
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0)),
                                                    onPressed: () {

                                                      getImage();
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 90,
                                                      child: Center(
                                                        child: Text(
                                                          "Choose Fille",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    )),
                                  ),
                                  Expanded(
                                    child: CustomFieldProducte("الوصــف",
                                        "أدخل وصف المنتج ", _editControllerDesc),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 265,
                                    child: CustomFieldProducte("السـعر",
                                        "اكتب السعر", _editControllerPrice),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 265,
                                    child: CustomFieldProducte("الخصـم",
                                        "أدخل الخصم", _editControllerDiscount),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              buttonsSelectorDialog(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

/*
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
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(Icons.close)),
                            Text(
                              "اضافة منتـج ",
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
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "اختار القسم",
                                      style: TextStyle(
                                          fontFamily: 'home',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 1, color: Colors.grey)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Center(
                                              child: DropdownButton<String>(
                                                underline: SizedBox(),
                                                value: dropdownValue,
                                                icon: Icon(Icons
                                                    .keyboard_arrow_down_sharp),
                                                iconSize: 24,
                                                isExpanded: true,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                onChanged: (data) {
                                                  dropdownValue = data!;
                                                  setState(() {});
                                                },
                                                items: spinnerItems.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )),
                          ),
                          Expanded(
                            child: CustomFieldProducte("اسم المنتج", _validate),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "اختار الصــورة",
                                      style: TextStyle(
                                          fontFamily: 'home',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black.withOpacity(.5)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "No file Chosen",
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
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            onPressed: () {},
                                            child: Container(
                                              height: 25,
                                              width: 90,
                                              child: Center(
                                                child: Text(
                                                  "Choose Fille",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            )),
                          ),
                          Expanded(
                            child: CustomFieldProducte("الوصــف", _validate),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 265,
                            child: CustomFieldProducte("السـعر", _validate),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 265,
                            child: CustomFieldProducte("الخصـم", _validate),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      buttonsSelectorDialog(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });*/
  }

  Padding buttonsSelectorDialog() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MaterialButton(
            color: Color(0xFF0069D9),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            onPressed: () {
              if (!_formKey.currentState!.validate()) {

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      'من فضلك أكمل البيانات ..',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      'ok ..',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Container(
              height: 40,
              width: 40,
              child: Center(
                child: Text(
                  "حفظ",
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
                  "اغلاق",
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
    );
  }

 }

class CustomFieldProducte extends StatefulWidget {
  final String hint;
  final _textValidate;

  TextEditingController _editController = TextEditingController();

  CustomFieldProducte(this.hint, this._textValidate, this._editController);

  @override
  _CustomFieldProducteState createState() => _CustomFieldProducteState();
}

class _CustomFieldProducteState extends State<CustomFieldProducte> {
  @override
  void dispose() {


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 8.0),
            child: Text(
              widget.hint,
              style: TextStyle(
                  fontFamily: 'home',
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(.5)),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          DialogTextField(
            widget.hint,
            widget._textValidate,
            widget._editController,
          )
        ],
      ),
    );
  }
}

class ItemListProduct extends StatelessWidget {

  final DataProduct dataProducts;
  final int index;

  ItemListProduct(this.dataProducts, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        border: TableBorder.all(
            color: Colors.black.withOpacity(.5),
            style: BorderStyle.solid,
            width: 1),
        children: [
          TableRow(children: [
            Container(
                width: 100,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                width: 100,
                height: 50,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MaterialButton(
                      hoverColor: Colors.black.withOpacity(0.6),
                      color: Color(0xFF0069D9),
                      onPressed: () {},
                      child: Text(
                        "تعديل",
                        style: TextStyle(
                            fontFamily: 'Schyler',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )),
            Container(
                padding: EdgeInsets.all(5),
                width: 60,
                child: Text(dataProducts.discount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 15.0))),
            Container(
                padding: EdgeInsets.all(5),
                width: 60,
                child: Text("${dataProducts.price}ج.م",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 13.0))),
            Container(
                padding: EdgeInsets.all(5),
                width: 120,
                height: 50,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: dataProducts.image,
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
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: 420,
                child: Text(dataProducts.desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 13.0))),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: 220,
                child: Text(dataProducts.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 40,
                child: Text(dataProducts.id.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
          ])
        ],
      ),
    );
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
                              onPressed: () {

                               Provider.of<ProviderProducts>(context,listen: false)
                                   .deleteProduct(dataProducts.id);
                               if( Provider.of<ProviderProducts>(context,listen: false).loadingDelete){

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

class TitleTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        border: TableBorder.all(
            color: Colors.black, style: BorderStyle.solid, width: 2),
        children: [
          TableRow(children: [
            Container(
                width: 100,
                child: Text('حذف',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 100,
                child: Text('تعديل',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 60,
                child: Text('الخصم',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 60,
                child: Text('السعر',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 120,
                child: Text('الصورة',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 420,
                child: Text('الوصف',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 220,
                child: Text('اسم المنتج ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
            Container(
                width: 40,
                child: Text('#',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Schyler', fontSize: 15.0))),
          ])
        ],
      ),
    );
  }
}
