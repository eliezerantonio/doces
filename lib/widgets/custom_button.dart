// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.enabled = false})
      : super(key: key);

  final String text;
  final Function onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: !enabled
          ? () {
              FocusScope.of(context).unfocus();
              onPressed();
            }
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            !enabled ? Colors.pink[300]! : Colors.grey,
            !enabled ? Colors.orange[300]! : Colors.grey[400]!,
          ]),
          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 40.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
