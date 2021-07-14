import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';
import 'package:private_gallery/fileview/videoview.dart';

import 'home.dart';

class HomeVideoList extends StatelessWidget {
  final FileIO fileIo;
  HomeVideoList(this.fileIo);
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(fileIo.videoCount, (index) =>  Hero(
          tag: "video_item$index",
          child: Card(
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> VideoViewerPage("video_item$index",PageController(initialPage: index))));
              },
              child: fileIo.getVideoAt(index).thumb
            ),
          ),
        ) )
     
    );
  }
}
