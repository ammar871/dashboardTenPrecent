import 'package:dashboard_web/pages/home_page.dart';
import 'package:dashboard_web/widget/custom_tect_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
static String id="LoginPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Login in DashBoard".toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                width: 100,
                color: Colors.green,
              ),
              SizedBox(
                height: 50,
              ),
              CustomTextField("Enter Your Email ..."),
              SizedBox(
                height: 20,
              ),
              CustomTextField("Enter Your Password ..."),
              SizedBox(
                height: 40,
              ),
              ButtonCustom(),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonCustom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)),
      color: Colors.black.withOpacity(0.7),
      splashColor: Colors.white,
      textColor: Colors.green,
      height: 45,
      elevation: 2,
      animationDuration: Duration(seconds: 5),
      hoverColor: Colors.black.withOpacity(0.6),
      onPressed: () {
        Navigator.of(context).pushNamed(HomePage.id);
      },
      child: Center(
        child: Text(
          "Login".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
