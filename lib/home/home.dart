import 'dart:async';

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

class _HomeState extends State<Home>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  TabController controller;
  FileIO fileIo;
  bool isAuthorized = false;
  Timer timer;
  ThemeMode themeMode = ThemeMode.system;
  int lockdelay;
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    FileIO.getFutureInstance().then((value) => setState(() {
          fileIo = value;
          themeMode = updateTheme();
          setLockDelay();
          WidgetsBinding.instance.addObserver(this);
        }));
  }

  void setLockDelay() {
    int temp;
    switch (fileIo.preferences.getString(FileIO.LOCKDELAY)) {
      case '0min':
        temp = 0;
        break;
      case '5sec':
        temp = 5;
        break;
      case '15sec':
        temp = 15;
        break;
      case '1min':
        temp = 60;
        break;
      case '5min':
        temp = 300;
        break;
      default:
        temp = -1;
    }
    setState(() {
      lockdelay = temp;
    });
  }

  ThemeMode updateTheme() {
    switch (fileIo.preferences.getString(FileIO.THEME)) {
      case 'dark':
        return ThemeMode.dark;
        break;
      case 'light':
        return ThemeMode.light;
        break;
      default:
        return ThemeMode.system;
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: themeMode,
        darkTheme: ThemeData.dark(),
        home: (fileIo == null)
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
                    ? PasswordPage(
                        fileIo.preferences.getString(FileIO.PASSWORD),
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
                        drawer: HomeDrawer(fileIo, () {
                          setState(() {
                            themeMode = updateTheme();
                            setLockDelay();
                          });
                        }),
                        body: HomeTabView(fileIo, controller),
                        bottomNavigationBar: HomeNavigationBar(controller),
                      ));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      registerIntervalLock(lockdelay);
    } else if (state == AppLifecycleState.resumed) {
      cancelTimer();
    }
  }

  void registerIntervalLock(int seconds) {
    if (seconds == -1) return;
    if (seconds == 0)
      setState(() {
        isAuthorized = false;
      });
    else
      timer = Timer(Duration(seconds: seconds), () {
        setState(() {
          isAuthorized = false;
        });
      });
  }

  void cancelTimer() {
    if (timer != null) if (timer.isActive) timer.cancel();
  }
}
