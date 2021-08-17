import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogTextField extends StatefulWidget {
  final String hint;
  final String textValidate;
  TextEditingController _editController = TextEditingController();

  DialogTextField(this.hint, this.textValidate, this._editController);

  @override
  _DialogTextFieldState createState() => _DialogTextFieldState();
}

class _DialogTextFieldState extends State<DialogTextField> {


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: TextFormField(
          textAlign: TextAlign.right,
          controller: widget._editController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.textValidate;
            }
            return null;
          },
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'bold',
              )),
        ));
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "من فضلك اكتب الاسم";
    }
    return null;
  }
}
