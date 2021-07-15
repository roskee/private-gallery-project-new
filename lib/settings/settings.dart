import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';

class SettingsPage extends StatefulWidget {
  final FileIO fileIo;
  final Function callback;
  String themevalue;
  SettingsPage(this.fileIo, this.callback) {
    themevalue = fileIo.preferences.getString(FileIO.THEME);
  }
  _SettingsPageState createState() => _SettingsPageState(themevalue);
}

class _SettingsPageState extends State<SettingsPage> {
  String themevalue;
  bool useFingerprint = false;
  _SettingsPageState(this.themevalue);
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
              // call ModalBottomSheet
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
