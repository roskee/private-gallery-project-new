import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalkThrough extends StatelessWidget {
  PageController controller;
  FocusNode primaryPin;
  FocusNode lastPin;
  TextEditingController primaryController;
  TextEditingController lastController;
  GlobalKey<FormState> formState;
  final Function finishCallback;
  WalkThrough(this.finishCallback) {
    controller = PageController();
    primaryPin = FocusNode(canRequestFocus: true);
    lastPin = FocusNode(canRequestFocus: true);
    primaryController = TextEditingController();
    lastController = TextEditingController();
    formState = GlobalKey<FormState>();
  }
  Widget build(BuildContext context) {
    return Material(
      child: PageView(
        controller: controller,
        children: [
          Center(
              child: Card(
                  child: SizedBox(
                      height: 400,
                      width: 250,
                      child: Center(
                        child: Text('Hello There!'),
                      )))),
          Center(
              child: Card(
                  child: SizedBox(
                      height: 400,
                      width: 250,
                      child: Center(
                        child: Text(
                          'Let\'s set your password',
                        ),
                      )))),
          Center(
              child: Card(
                  child: SizedBox(
                      height: 400,
                      width: 250,
                      child: Center(
                          child: Form(
                        key: formState,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Type a 4 digit pin'),
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: primaryController,
                                  validator: (value) {
                                    if (value.length != 4)
                                      return 'Your pin must be 4 digits long';
                                    return null;
                                  },
                                  focusNode: primaryPin,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 4,
                                )),
                            Text('Type your pin again!'),
                            SizedBox(
                                width: 200,
                                child: TextFormField(
                                  controller: lastController,
                                  validator: (value) {
                                    if (value.length != 4)
                                      return 'Your pin must be 4 digits long';
                                    if (value != primaryController.value.text)
                                      return 'Your pin doesn\'t match';
                                    return null;
                                  },
                                  focusNode: lastPin,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 4,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  if (formState.currentState.validate())
                                    finishCallback(
                                        primaryController.value.text);
                                },
                                child: Text('Finish'))
                          ],
                        ),
                      ))))),
        ],
      ),
    );
  }
}
