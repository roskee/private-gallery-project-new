import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';
import 'package:private_gallery/home/drawer.dart';
import 'package:private_gallery/home/expandablefloatingbutton/expandablefab.dart';
import 'package:private_gallery/home/navigationbar.dart';
import 'package:private_gallery/home/splash.dart';
import 'package:private_gallery/home/tabview.dart';
import 'package:private_gallery/home/walkthrough.dart';
import 'auth.dart';
import 'expandablefloatingbutton/actionbutton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController controller;
  FileIO fileIo;
  bool isAuthorized = false;
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    FileIO.getFutureInstance().then((value) => setState(() {
          fileIo = value;
        }));
  }

  Widget build(BuildContext context) {
    return (fileIo == null)
        ? SplashScreen()
        : (fileIo.preferences.getBool(FileIO.NOOBIE))
            ? WalkThrough((value) {
                setState(() {
                  fileIo.preferences.setBool(FileIO.NOOBIE, false);
                  fileIo.preferences.setString(FileIO.PASSWORD, value);
                  isAuthorized = true;
                });
              })
            : (!isAuthorized)
                ? PasswordPage(fileIo.preferences.getString(FileIO.PASSWORD),
                    fileIo.preferences.getBool(FileIO.USE_FINGERPRINT), () {
                    setState(() {
                      isAuthorized = true;
                    });
                  })
                : Scaffold(
                    appBar: AppBar(
                      title: Text("Private Gallery"),
                    ),
                    floatingActionButton: ExpandableFab(
                      distance: 100,
                      children: [
                        ActionButton(
                          onPressed: () {},
                          icon: Icon(Icons.image),
                          label: 'Image',
                        ),
                        ActionButton(
                          onPressed: () {},
                          icon: Icon(Icons.video_label),
                          label: 'Video',
                        ),
                        ActionButton(
                          onPressed: () {},
                          icon: Icon(Icons.file_present),
                          label: 'Other',
                        )
                      ],
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.miniEndFloat,
                    drawer: HomeDrawer(fileIo),
                    body: HomeTabView(fileIo, controller),
                    bottomNavigationBar: HomeNavigationBar(controller),
                  );
  }
}
