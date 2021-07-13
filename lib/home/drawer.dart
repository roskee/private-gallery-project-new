import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
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
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About App'),
                )
              ],
            ))
      ],
    ));
  }
}
