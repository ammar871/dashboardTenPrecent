import 'package:dashboard_web/pages/category_page.dart';
import 'package:dashboard_web/pages/notifecation_page.dart';
import 'package:dashboard_web/pages/one_page.dart';
import 'package:dashboard_web/pages/ordersPage.dart';
import 'package:dashboard_web/pages/products_page.dart';
import 'package:dashboard_web/pages/slider_app_page.dart';
import 'package:dashboard_web/pages/users_page.dart';
import 'package:dashboard_web/providers/provider_back.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  List<Widget> listWdigts = [
    OnePageScreen(),
    CategoryPage(),
    ProductsPage(),
    OrdersPage(),
    UsersPage(),
    SliderPage()

  ];

  @override
  Widget build(BuildContext context) {
    _index= context.read<CounterProvider>().count;
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: listWdigts[_index],
          ),
          Expanded(child: sideMenu())
        ],
      ),
    );
  }

  Container sideMenu() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFF2C394B),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: new Image.asset(
              "images/logo.jpg",
              height: 80.0,
              width: 80.0,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "ten Percent".toUpperCase(),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 80,
            height: 2,
            color: Colors.brown,
          ),
          SizedBox(
            height: 25,
          ),
          itemMenu("الرئيسية", Icons.home, context.watch<CounterProvider>().count==0 ? Colors.lightBlueAccent
              :Colors.transparent, () {
            setState(() {

              context.read<CounterProvider>().increment(0);
            });
          }),
          itemMenu("الأقسام", Icons.view_module_sharp, context.watch<CounterProvider>().count==1 ? Colors.lightBlueAccent
              :Colors.transparent, () {
            setState(() {
              context.read<CounterProvider>().increment(1);
            });
          }),
          itemMenu("المنتجات", Icons.add_shopping_cart_sharp,context.watch<CounterProvider>().count==2 ? Colors.lightBlueAccent
              :Colors.transparent,
              () {

            setState(() {
              context.read<CounterProvider>().increment(2);
            });
          }),

          itemMenu("الطلبات", Icons.airport_shuttle,context.watch<CounterProvider>().count==3 ? Colors.lightBlueAccent
              :Colors.transparent, () {
            setState(() {
              context.read<CounterProvider>().increment(3);
            });
          }),
          itemMenu("العملاء", Icons.people, context.watch<CounterProvider>().count==4 ? Colors.lightBlueAccent
              :Colors.transparent, () {
            setState(() {
              context.read<CounterProvider>().increment(4);
            });
          }),
          itemMenu("سليدر التطبيق", Icons.slideshow, context.watch<CounterProvider>().count==5 ? Colors.lightBlueAccent
              :Colors.transparent, () {
            setState(() {
              context.read<CounterProvider>().increment(5);
            });
          }),
        ],
      ),
    );
  }
}

class itemMenu extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Function function;

  itemMenu(this.text, this.icon, this.color, this.function);

  @override
  _itemMenuState createState() => _itemMenuState();
}

class _itemMenuState extends State<itemMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: MaterialButton(
        height: 35,
       color: widget.color,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0),
        ),
        onPressed: () {
          widget.function();
        },
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'fonttwo',
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    widget.icon,
                    size: 25,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
