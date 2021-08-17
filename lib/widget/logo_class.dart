import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoClass extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50,),
            Text("أهــلا",
              style: TextStyle(

                  fontWeight: FontWeight.bold
                  , color: Colors.green
                  , fontSize: 35,
                  fontFamily: "bold"
              ),),

            Text("مرحبا بك فى لوحة التحكم ",
              style: TextStyle(
                  fontWeight: FontWeight.bold
                  , color: Colors.blue
                  , fontSize: 15,
                  fontFamily: "bold"
              ),)
          ],

        ),
        SizedBox(width: 10),
        Padding(
            padding: EdgeInsets.only(right: 40, top: 40),
            child: SvgPicture.asset(
              "images/shop.svg",
              width: 70,
              height: 70,
            )),


      ],
    );
  }
}