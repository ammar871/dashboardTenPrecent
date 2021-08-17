import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_web/constans.dart';
import 'package:dashboard_web/pages/ordersPage.dart';
import 'package:dashboard_web/pages/products_page.dart';
import 'package:dashboard_web/pages/users_page.dart';
import 'package:dashboard_web/pojo/orders_model.dart';
import 'package:dashboard_web/providers/provider_back.dart';
import 'package:dashboard_web/providers/provider_orders.dart';

import 'package:dashboard_web/widget/logo_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'category_page.dart';

class OnePageScreen extends StatefulWidget {
  @override
  _OnePageSvreenState createState() => _OnePageSvreenState();
}

class _OnePageSvreenState extends State<OnePageScreen> {
  int index = 0;

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

  initData() async {
    index = context.watch<CounterProvider>().count;
  }

  List<Widget> screens = [
    OnePageScreen(),
    CategoryPage(),
    OrdersPage(),
    ProductsPage(),
    UsersPage()
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      appBar: index == 0
          ? AppBar(
              backgroundColor: Colors.blue,
            )
          : null,
      body: index == 0
          ? ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LogoClass(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          WedgitCounterHome(
                              Icons.person, "عدد العملاء", Colors.teal, () {
                            setState(() {
                              context.read<CounterProvider>().increment(4);
                            });
                          }),
                          SizedBox(
                            width: 8,
                          ),
                          WedgitCounterHome(Icons.shopping_basket_rounded,
                              'عدد المنتجات', KRed, () {
                            setState(() {
                              context.read<CounterProvider>().increment(2);
                              //  index=3;
                            });
                          }),
                          SizedBox(
                            width: 8,
                          ),
                          WedgitCounterHome(
                              Icons.shopping_cart, 'عدد الطلبيات', Kyallow, () {
                            setState(() {
                              context.read<CounterProvider>().increment(3);
                              // index=2;
                            });
                          }),
                          SizedBox(
                            width: 8,
                          ),
                          WedgitCounterHome(
                              Icons.view_module, 'عدد الاقسام', KTeal, () {
                            setState(() {
                              context.read<CounterProvider>().increment(1);
                              // index=1;
                            });
                          })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 1 + list.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return index == 0
                              ? TitleTableOrders()
                              : Padding(
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
                                                    showDailogDetails(
                                                        _providerOrders
                                                            .list[index]
                                                            .products);
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
                                            child: Text(
                                                _providerOrders
                                                    .list[index].totalCost
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 15.0))),
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            width: 300,
                                            child: Text(
                                                _providerOrders
                                                    .list[index].user.email,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 15.0))),
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            width: 300,
                                            child: Text(
                                                _providerOrders
                                                    .list[index].user.phone,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 15.0))),
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            width: 200,
                                            child: Text(
                                                _providerOrders
                                                    .list[index].user.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'bold',
                                                    fontSize: 15.0))),
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            width: 40,
                                            child: Text(
                                                _providerOrders.list[index].id
                                                    .toString(),
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
                )
              ],
            )
          : screens[index],
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    child: Table(
                                      defaultColumnWidth:
                                          IntrinsicColumnWidth(),
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
                                                  placeholder: (context, url) =>
                                                      Icon(
                                                    Icons.photo_sharp,
                                                    color: Colors.black12,
                                                    size: 55,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons.photo_sharp,
                                                    color: Colors.black12,
                                                    size: 55,
                                                  ),
                                                ),
                                              )),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 100,
                                              child: Text(
                                                  list[index]
                                                      .discount
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 100,
                                              child: Text(
                                                  list[index].price.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 100,
                                              child: Text(
                                                  list[index]
                                                      .quantity
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 200,
                                              child: Text(
                                                  list[index].desc.toString(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 200,
                                              child: Text(
                                                  list[index].name.toString(),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 15.0))),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              width: 40,
                                              child: Text(
                                                  list[index].id.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'bold',
                                                      fontSize: 15.0))),
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

class ItemListOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(
                    "images/logo.jpg",
                    height: 60,
                    width: 60,
                  )),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  child: Text('الخصم',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  child: Text('السعر',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  child: Text('الكمية',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 200,
                  child: Text('الوصف',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 200,
                  child: Text('اسم المنتج ',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 40,
                  child: Text('#',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
            ])
          ],
        ),
      ),
    );
  }
}

class WedgitCounterHome extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Function function;

  WedgitCounterHome(this.icon, this.title, this.color, this.function);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MaterialButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(7.0),
      ),
      onPressed: () {
        function();
      },
      color: Colors.white,
      hoverColor: Colors.green,
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            Positioned(
              left: 20,
              bottom: 20,
              child: Text(
                "15",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "bold"),
              ),
            ),
            Positioned(
                right: 10,
                top: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(icon, size: 50, color: color),
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.6),
                          fontSize: 20,
                          fontFamily: "bold"),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}

class TitleTableOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        border: TableBorder.all(
            color: Colors.black.withOpacity(.6),
            style: BorderStyle.solid,
            width: 1),
        children: [
          TableRow(children: [
            Container(
                padding: EdgeInsets.all(8),
                width: 100,
                child: Text('التفاصيل',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
            Container(
                padding: EdgeInsets.all(8),
                width: 100,
                child: Text('المبلغ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
            Container(
                padding: EdgeInsets.all(8),
                width: 300,
                child: Text('البريد الالكترونى',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
            Container(
                padding: EdgeInsets.all(8),
                width: 300,
                child: Text('الهاتف',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
            Container(
                padding: EdgeInsets.all(8),
                width: 200,
                child: Text('الاسم ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
            Container(
                padding: EdgeInsets.all(8),
                width: 40,
                child: Text('#',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
          ])
        ],
      ),
    );
  }
}

class TitleTableDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        color: Color(0xFFF3F4F6),
        child: Table(
          defaultColumnWidth: IntrinsicColumnWidth(),
          children: [
            TableRow(children: [
              Container(
                  padding: EdgeInsets.all(8),
                  width: 150,
                  child: Text('صورة المنتج',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  child: Text('الخصم',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  child: Text('السعر',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  child: Text('الكمية',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 200,
                  child: Text('الوصف',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 200,
                  child: Text('اسم المنتج ',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
              Container(
                  padding: EdgeInsets.all(8),
                  width: 40,
                  child: Text('#',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'bold', fontSize: 15.0))),
            ])
          ],
        ),
      ),
    );
  }
}
