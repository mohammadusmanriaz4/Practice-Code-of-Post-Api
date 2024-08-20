import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils
{

  void toastMessage (String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 248, 1, 178),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  
}