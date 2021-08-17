import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_web/pojo/orders_model.dart';
import 'package:dashboard_web/providers/provider_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'one_page.dart';

class OrdersPage extends StatefulWidget {
  

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {


  late ProviderOrders _providerOrders;

  late List<DataOrders> list;
  bool loading = false;

  getData() async {
    list = [];
    _providerOrders = Provider.of(context);

    _providerOrders.getOrdersData("1");
    list = _providerOrders.list;
    setState(() {
      loading = _providerOrders.loading;
    });
    print(_providerOrders.list.length);
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
      body: ListView(
        children: [
          SizedBox(height: 40,)
          ,
         // TitleTableOrders(),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext ctx, index) {
                return index==-0?TitleTableOrders():Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: Table(
                    defaultColumnWidth: IntrinsicColumnWidth(),
                    border: TableBorder.all(
                        color: Colors.black.withOpacity(.5),
                        style: BorderStyle.solid,
                        width: 1),
                    children: [
                      TableRow(children: [
                        Container(
                            padding: EdgeInsets.all(8),
                            width: 100,
                            child: Center(
                              child: Padding(
                                padding:
                                const EdgeInsets.all(5.0),
                                child: MaterialButton(
                                  hoverColor: Colors.black
                                      .withOpacity(0.6),
                                  color: Color(0xFF0069D9),
                                  onPressed: () {
                                    showDailogDetails(_providerOrders.list[index].products);
                                  },
                                  child: Text(
                                    "التفاصيل",
                                    style: TextStyle(
                                        fontFamily: 'Schyler',
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            padding: EdgeInsets.all(8),
                            width: 100,
                            child: Text(_providerOrders.list[index].totalCost.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 15.0))),
                        Container(
                            padding: EdgeInsets.all(8),
                            width: 300,
                            child: Text(_providerOrders.list[index].user.email,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 15.0))),
                        Container(
                            padding: EdgeInsets.all(8),
                            width: 300,
                            child: Text(_providerOrders.list[index].user.phone,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 15.0))),
                        Container(
                            padding: EdgeInsets.all(8),
                            width: 200,
                            child: Text(_providerOrders.list[index].user.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 15.0))),
                        Container(
                            padding: EdgeInsets.all(8),
                            width: 40,
                            child: Text(_providerOrders.list[index].id.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 15.0))),
                      ])
                    ],
                  ),
                );
              })

        ],
      ),
    );
  }
  void showDailogDetails(List<Products> list) {
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
                width: MediaQuery.of(context).size.width * 0.7,
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
                              "تفاصيل الطلب ",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(.8)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TitleTableDetails(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    child: Table(
                                      defaultColumnWidth: IntrinsicColumnWidth(),
                                      border: TableBorder.all(
                                          color: Colors.black.withOpacity(.4),
                                          style: BorderStyle.solid,
                                          width: .8),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 150,
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
                                              )),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 100,
                                              child: Text(list[index].discount.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 100,
                                              child: Text(list[index].price.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 100,
                                              child: Text(list[index].quantity.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 200,
                                              child: Text(list[index].desc.toString(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 200,
                                              child: Text(list[index].name.toString(),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 40,
                                              child: Text(list[index].id.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
                                        ])
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                    "اغلاق",
                                    style: TextStyle(
                                        fontFamily: 'bold',
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
