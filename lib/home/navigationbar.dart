import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeNavigationBar extends StatelessWidget{
  final TabController controller;
  HomeNavigationBar(this.controller);
  Widget build(BuildContext context){
    return Material(
      child: TabBar(
      controller: controller,
      labelColor: Colors.blue,
      
      tabs: [
        Tab(
          icon: Icon(Icons.image),
          child: Text('Images'),
        ),
        Tab(
          icon: Icon(Icons.video_label),
          child: Text('Videos'),
        ),
        Tab(
          icon: Icon(Icons.book),
          child: Text('Files'),
        )
      ],
    ));
  }
}