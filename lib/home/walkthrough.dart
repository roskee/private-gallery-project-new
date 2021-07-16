import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalkThrough extends StatefulWidget {
  final Function finishCallback;
  WalkThrough(this.finishCallback);
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  PageController controller;
  FocusNode primaryPin;
  FocusNode lastPin;
  TextEditingController primaryController;
  TextEditingController lastController;
  GlobalKey<FormState> formState;
  _WalkThroughState() {
    controller = PageController();
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
                                    return (value.length != 4)
                                        ? 'Your pin must be 4 digits long'
                                        : null;
                                  },
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
                                    return (value.length != 4)
                                        ? 'Your pin must be 4 digits long'
                                        : (value !=
                                                primaryController.value.text)
                                            ? 'Your pin doesn\'t match'
                                            : null;
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 4,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  if (formState.currentState.validate())
                                    widget.finishCallback(
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
