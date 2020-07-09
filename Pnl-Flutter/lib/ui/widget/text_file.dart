import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  final String hint;
  final TextInputType keyboard;
  final TextEditingController controller;
  final Function validator;
  final String error;
  MyTextField({this.label, this.maxLines = 1, this.minLines = 1, this.icon,this.controller,this.hint,this.keyboard,this.error,this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.black87),
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboard,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: icon == null ? null: icon,
          labelText: label,
          errorText: error,
          labelStyle: TextStyle(color: Colors.black45),
          hintText: hint,
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }
}