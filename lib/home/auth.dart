import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordPage extends StatelessWidget {
  final String password;
  final bool useFingerprint;
  final Function verifiedCallback;
  PasswordPage(this.password, this.useFingerprint, this.verifiedCallback);
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 250,
            height: 200,
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      'Hey! What is the secret code?',
                    ),
                  ),
                ),
                TextField(
                  autofocus: true,
                  obscureText: true,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value == password) verifiedCallback();
                  },
                )
              ],
            ))),
        Visibility(
            visible: useFingerprint,
            child: SizedBox(
              width: 250,
              child: Column(
                children: [
                  Text('Try your finger!'),
                  Image.asset('assets/images/fingerprint.png'),
                ],
              ),
            ))
      ],
    );
  }
}
