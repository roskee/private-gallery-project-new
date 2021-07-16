import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:private_gallery/fileio/fileio.dart';

class SettingsPage extends StatefulWidget {
  final FileIO fileIo;
  final Function callback;
  SettingsPage(this.fileIo, this.callback);
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String themevalue;
  String lockvalue;
  String lastPassword;
  bool useFingerprint;
  GlobalKey<FormState> formState;
  TextEditingController firstController, primaryController, lastController;
  _SettingsPageState();
  void initState() {
    super.initState();
    useFingerprint = widget.fileIo.preferences.getBool(FileIO.USE_FINGERPRINT);
    themevalue = widget.fileIo.preferences.getString(FileIO.THEME);
    lockvalue = widget.fileIo.preferences.getString(FileIO.LOCKDELAY);
    lastPassword = widget.fileIo.preferences.getString(FileIO.PASSWORD);
    formState = GlobalKey<FormState>();
    firstController = TextEditingController();
    primaryController = TextEditingController();
    lastController = TextEditingController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.style),
            title: Text('Theme'),
            trailing: DropdownButton(
              value: themevalue,
              onChanged: (value) {
                setState(() {
                  themevalue = value;
                });
                widget.fileIo.preferences.setString(FileIO.THEME, value);
                widget.callback();
              },
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  value: 'dark',
                  child: Text('Dark'),
                ),
                DropdownMenuItem(
                  value: 'light',
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: 'system',
                  child: Text('System Default'),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Change Password'),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => BottomSheet(
                      onClosing: () {},
                      builder: (context) => Form(
                          key: formState,
                          child: Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text('Enter your old pin'),
                              ),
                              SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    controller: firstController,
                                    validator: (value) {
                                      return (value != lastPassword)
                                          ? "This is not your pin!"
                                          : null;
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    maxLength: 4,
                                  )),
                              SizedBox(
                                  width: 200,
                                  child: Text('Enter your new pin below')),
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
                              SizedBox(
                                  width: 200,
                                  child: Text('Enter your new pin again')),
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
                                    if (formState.currentState.validate()) {
                                      widget.fileIo.preferences.setString(
                                          FileIO.PASSWORD,
                                          primaryController.value.text);
                                      Navigator.of(context).pop();
                                      setState(() {
                                        lastPassword =
                                            primaryController.value.text;
                                        primaryController.clear();
                                        lastController.clear();
                                        firstController.clear();
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Password changed!'),
                                      ));
                                    }
                                  },
                                  child: Text('Change Password'))
                            ],
                          )))));
            },
          ),
          ListTile(
            leading: Icon(Icons.fingerprint),
            title: Text('Use fingerprint'),
            onTap: () {
              setState(() {
                useFingerprint = !useFingerprint;
              });
            },
            trailing: Switch(
              value: useFingerprint,
              onChanged: (value) {
                setState(() {
                  useFingerprint = value;
                });
                widget.fileIo.preferences
                    .setBool(FileIO.USE_FINGERPRINT, useFingerprint);
                widget.callback();
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Auto lock delay'),
            trailing: DropdownButton(
              value: lockvalue,
              onChanged: (value) {
                setState(() {
                  lockvalue = value;
                  widget.fileIo.preferences.setString(FileIO.LOCKDELAY, value);
                  widget.callback();
                });
              },
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  value: '0min',
                  child: Text('Immediately'),
                ),
                DropdownMenuItem(
                  value: '5sec',
                  child: Text('After 5 seconds'),
                ),
                DropdownMenuItem(
                  value: '15sec',
                  child: Text('After 15 seconds'),
                ),
                DropdownMenuItem(
                  value: '1min',
                  child: Text('After 1 minute'),
                ),
                DropdownMenuItem(
                  value: '5min',
                  child: Text('After 5 minutes'),
                ),
                DropdownMenuItem(
                  value: 'never',
                  child: Text('Never'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
