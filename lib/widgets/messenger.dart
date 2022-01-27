import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void messenger(String sms, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.pink[300],
      content: Text(sms),
    ),
  );
}
