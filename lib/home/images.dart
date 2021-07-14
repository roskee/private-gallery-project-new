import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/fileio.dart';
import 'package:private_gallery/fileview/imageview.dart';

class HomeImageList extends StatelessWidget {
  final FileIO fileIo;
  HomeImageList(this.fileIo);
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(fileIo.imageCount, (index) => Hero(
          tag: "image_item$index",
          child: Card(
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> ImageViewerPage("image_item$index",PageController(initialPage: index),fileIo)));
            },
              child: fileIo.getImageAt(index)
            ),
          ),
        ))
    );
  }
}
