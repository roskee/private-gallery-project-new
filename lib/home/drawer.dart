import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/about/about.dart';
import 'package:private_gallery/fileio/fileio.dart';
import 'package:private_gallery/settings/settings.dart';

class HomeDrawer extends StatelessWidget {
  final FileIO fileIo;
  final Function settingsCallback;
  HomeDrawer(this.fileIo, this.settingsCallback);
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Expanded(
          child: Image.asset("assets/images/private_gallery_icon.png"),
          flex: 3,
        ),
        Expanded(
            flex: 5,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => SettingsPage(fileIo, () {
                            settingsCallback();
                          }))),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About App'),
                  onTap: () => Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => AboutPage())),
                )
              ],
            ))
      ],
    ));
  }
}
