import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitlesTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 40,
        width: double.infinity,
        child: Row(
          children: [

            Container(
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color:Colors.black,width: 0.5)
                ),
                child: Center(
                  child: Text("حذف",style: TextStyle(
                      fontFamily: 'fonttwo',fontSize: 14,fontWeight: FontWeight.bold,
                      color: Colors.black),),
                )
            ),
            Container(
                width: 90,
                height:60,
                decoration: BoxDecoration(
                    border: Border.all(color:Colors.black,width: 0.5)
                ),
                child: Center(
                  child: Text("تعديل",style: TextStyle(fontFamily: 'fonttwo',fontSize: 14,fontWeight: FontWeight.bold,
                      color: Colors.black),),
                )
            ),
            Container(
                width: 150,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color:Colors.black,width: 0.5)
                ),
                child: Center(
                  child: Text("الصورة",style: TextStyle(fontFamily: 'fonttwo',fontSize: 14,fontWeight: FontWeight.bold,
                      color: Colors.black),),
                )
            ),
            Expanded(child: Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color:Colors.black,width: 0.5)
                ),
                child: Center(
                  child: Text("اسم القسم",style: TextStyle(fontFamily: 'fonttwo',fontSize: 14,fontWeight: FontWeight.bold,
                      color: Colors.black),),
                )
            )),
            Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color:Colors.black,width: 0.5)
              ),
              child: Center(
                child: Text("#",style: TextStyle(fontFamily: 'fonttwo',fontSize: 14,fontWeight: FontWeight.bold,
                    color: Colors.black),),
              ),
            ),


          ],

        ));
  }
}