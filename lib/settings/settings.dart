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
  String lastPassword;
  bool useFingerprint;
  GlobalKey<FormState> formState;
  TextEditingController firstController, primaryController, lastController;
  _SettingsPageState();
  void initState() {
    super.initState();
    useFingerprint = widget.fileIo.preferences.getBool(FileIO.USE_FINGERPRINT);
    themevalue = widget.fileIo.preferences.getString(FileIO.THEME);
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
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width:200,child:Text('Enter your old pin'),),
                              
                              SizedBox(
                                width: 200,
                                child:TextFormField(
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
                              SizedBox(width:200,child:Text('Enter your new pin below')),
                              SizedBox(
                                width:200,
                                child:TextFormField(
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
                              SizedBox(width:200,child:Text('Enter your new pin again')),
                              SizedBox(
                                width:200,
                                child:TextFormField(
                                controller: lastController,
                                validator: (value) {
                                  return (value.length != 4)
                                      ? 'Your pin must be 4 digits long'
                                      : (value != primaryController.value.text)
                                          ? 'Your pin doesn\'t match'
                                          : null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 4,
                              )),
                              ElevatedButton(onPressed: (){
                                if(formState.currentState.validate()){
                                  Navigator.of(context).pop();
                                }

                              }, child: Text('Change Password'))
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
          )
        ],
      ),
    );
  }
}
