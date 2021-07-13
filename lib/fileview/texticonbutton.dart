import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  final Icon icon;
  final Text label;
  final Function onTap;
  TextIconButton(this.icon, this.label, this.onTap);
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [icon, label],
        )));
  }
}
