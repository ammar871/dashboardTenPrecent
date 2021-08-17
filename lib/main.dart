import 'package:dashboard_web/pages/home_page.dart';
import 'package:dashboard_web/pages/login_page.dart';
import 'package:dashboard_web/providers/products_provider.dart';
import 'package:dashboard_web/providers/provider_addCategory.dart';
import 'package:dashboard_web/providers/provider_back.dart';
import 'package:dashboard_web/providers/provider_category.dart';
import 'package:dashboard_web/providers/provider_orders.dart';
import 'package:dashboard_web/providers/provider_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ProviderCategory(),
        ),
        ChangeNotifierProvider(create: (_) => ProviderAddCategory(),
        ),
        ChangeNotifierProvider(create: (_) => ProviderProducts(),
        ),
        ChangeNotifierProvider(create: (_) => ProviderOrders(),
        ),
        ChangeNotifierProvider(create: (_) => ProviderUsers(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          HomePage.id: (context) => HomePage(),
          LoginPage.id: (context) => LoginPage(),

          //  '/test':(context) => TestingFlutter()
        },
      ),
    );
  }
}
