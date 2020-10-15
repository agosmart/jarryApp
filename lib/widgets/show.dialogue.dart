import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/utils/jari_icons_v2.dart';

class CustomDialigue extends StatelessWidget {
  //+++++++++++
  final String uiType; // Material - Cupertino
  final String title;
  final String textContent;
  final IconData icon;
  final Color iconColor;
  final int action;
  final void Function() submit;
  //+++++++++++
  const CustomDialigue({
    Key key,
    this.uiType = 'Material',
    this.title,
    this.textContent,
    this.submit,
    this.icon = JariIcons.check_circle,
    this.iconColor = AppColors.icongray_1,
    this.action = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return uiType == 'Material'
        ? materialDialog(context)
        : cupertinoDialog(context);
  }

  //+++++++++++++++++++++++++++++++++++++
  Widget materialDialog(context) {
    return AlertDialog(
      title: Column(
        children: <Widget>[
          Text("$title"),
          Icon(
            icon,
            color: iconColor,
          ),
        ],
      ),
      content: Text("$textContent"),
      actions: action == 1
          ? <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              )
            ]
          : <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Annuler"),
              ),
              FlatButton(
                onPressed: submit,
                child: Text("OK"),
              ),
            ],
    );
  }
  //+++++++++++++++++++++++++++++++++++++

  Widget cupertinoDialog(context) {
    return CupertinoAlertDialog(
      title: Column(
        children: <Widget>[
          Text("$title"),
          Icon(
            icon,
            color: iconColor,
          ),
        ],
      ),
      content: Text("$textContent"),
      actions: action == 1
          ? <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              )
            ]
          : <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Annuler"),
              ),
              FlatButton(
                onPressed: submit,
                child: Text("OK"),
              ),
            ],
    );
  }

  //+++++++++++++++++++++++++++++++++
}
