
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';

class SettingsPage extends StatefulWidget {
  final FileIO fileIo;
  SettingsPage(this.fileIo);
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String themevalue = 'system';
  bool useFingerprint = false;
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
                  widget.fileIo.preferences.setString(FileIO.THEME, value);
                });
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
                widget.fileIo.preferences
                    .setBool(FileIO.USE_FINGERPRINT, useFingerprint);
              });
            },
            trailing: Switch(
              value: useFingerprint,
              onChanged: (value) {
                setState(() {
                  useFingerprint = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
