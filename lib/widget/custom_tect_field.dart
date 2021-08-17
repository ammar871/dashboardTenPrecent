import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
final String hint;

CustomTextField(this.hint);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(8.0),
          )
          ,focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color:  Colors.green,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.green)
      ),


    );
  }
}