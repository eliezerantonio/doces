import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void customShowDialog({BuildContext? context}) {
  showCupertinoDialog(
    context: context!,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text("Ir pra Home"),
        content: Text("Tem certeza que pretende ir pra home?"),
        actions: <Widget>[
          CupertinoButton(
            child: Text("Sim"),
            onPressed: () {},
          )
        ],
      );
    },
  );
}
