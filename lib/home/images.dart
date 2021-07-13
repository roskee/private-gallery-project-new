import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileview/imageview.dart';

class HomeImageList extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        Hero(
          tag: "item",
          child: Card(
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> ImageViewerPage(PageController(initialPage: 0))));
              },
              child: Image.asset("assets/images/private_gallery_icon.png"),
            ),
          ),
        ),
        Card(
          child: Image.asset("assets/images/private_gallery_icon.png"),
        ),
         Card(
          child: Image.asset("assets/images/private_gallery_icon.png"),
        ),
         Card(
          child: Image.asset("assets/images/private_gallery_icon.png"),
        ),
         Card(
          child: Image.asset("assets/images/private_gallery_icon.png"),
        ),
         Card(
          child: Image.asset("assets/images/private_gallery_icon.png"),
        ),
      ],
    );
  }
}
