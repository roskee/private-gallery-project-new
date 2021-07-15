import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';
import 'package:private_gallery/home/drawer.dart';
import 'package:private_gallery/home/expandablefloatingbutton/expandablefab.dart';
import 'package:private_gallery/home/navigationbar.dart';
import 'package:private_gallery/home/tabview.dart';

import 'expandablefloatingbutton/actionbutton.dart';

class Home extends StatefulWidget{
  @override
    _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  TabController controller;
  static FileIO fileIo;
  void initState(){
    super.initState();
    controller  = new TabController(length: 3, vsync: this);
    fileIo = new FileIO();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Private Gallery"),),
      floatingActionButton: ExpandableFab(
        distance: 100,children: [
        ActionButton(onPressed: (){},icon: Icon(Icons.image),label: 'Image',),
        ActionButton(onPressed: (){},icon: Icon(Icons.video_label), label: 'Video',),
        ActionButton(onPressed: (){},icon: Icon(Icons.file_present), label: 'Other',)
      ],),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      drawer: HomeDrawer(),
      body: HomeTabView(fileIo, controller),
      bottomNavigationBar: HomeNavigationBar(controller),
    );
  }
}