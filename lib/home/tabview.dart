import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';
import 'package:private_gallery/home/files.dart';
import 'package:private_gallery/home/images.dart';
import 'package:private_gallery/home/videos.dart';

class HomeTabView extends StatelessWidget{
  final FileIO fileIo;
  final TabController controller;
  HomeTabView(this.fileIo, this.controller);
  Widget build(BuildContext context){
    return TabBarView(
      controller: controller,
      children: [
        HomeImageList(fileIo),
        HomeVideoList(fileIo),
        HomeFileList(fileIo),
    ]);
  }
}