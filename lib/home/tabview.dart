import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/home/images.dart';

class HomeTabView extends StatelessWidget{
  final TabController controller;
  HomeTabView( this.controller);
  Widget build(BuildContext context){
    return TabBarView(
      controller: controller,
      children: [
        HomeImageList(),
        Container(
          child: Text('Hello Again'),
        ),
        Container(
          child: Text("hello 3rd time"),
        )
    ]);
  }
}