import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

showToast(BuildContext context, String text) {
  return Fluttertoast.showToast(
      msg: text,
      
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white);
}
