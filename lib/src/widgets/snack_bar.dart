import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomSnackBar{
  static showSnackbar(BuildContext context,title,Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(title),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 110,
          left: 10,
          right: 10),
      dismissDirection: DismissDirection.up,
      action: SnackBarAction(
        label: 'CLOSE',
        textColor: Colors.red,
        onPressed: () {
          // SnackBar will be dismissed
        },
      ),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar,);
    return snackBar;
  }
  static toast(title) {
    return toastification.show(
      title: Text(title),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}
