import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color miColorPersonalizado = const Color(0xFF1F3DD0);

void showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: miColorPersonalizado,  // Corrección aquí
    textColor: Colors.white,
    fontSize: 16.0,
  );
}