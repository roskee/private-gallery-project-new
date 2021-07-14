import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:private_gallery/fileio/fileio.dart';
import 'package:private_gallery/fileview/texticonbutton.dart';

class ImageViewerPage extends StatefulWidget {
  final String heroTag;
  final PageController controller;
  final FileIO fileIo;
  ImageViewerPage(this.heroTag, this.controller, this.fileIo);
  _ImageViewerPageState createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  bool appBarVisible = false;
  int currentIndex = 0;
  Widget build(BuildContext context) {
    return Hero(
        tag: widget.heroTag,
        child: Scaffold(
            appBar: (appBarVisible) ? AppBar(title: Text('file Name')) : null,
            extendBodyBehindAppBar: true,
            body: InkWell(
                onTap: () {
                  setState(() {
                    appBarVisible = !appBarVisible;
                  });
                },
                child: Stack(
                  children: [
                    Center(
                      child: PageView(
                          controller: widget.controller,
                          onPageChanged: (index) {
                            currentIndex = index;
                          },
                          children: List.generate(
                              widget.fileIo.imageCount,
                              (index) => PhotoView(
                                  imageProvider: widget.fileIo
                                      .getImageAt(index)
                                      .image)) // must be from file controller

                          ),
                    ),
                    Visibility(
                        visible: appBarVisible,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              // bottom sheet like row
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: TextIconButton(Icon(Icons.restore),
                                        Text('Restore'), () {})),
                                Expanded(
                                    child: TextIconButton(Icon(Icons.delete),
                                        Text('Delete'), () {})),
                                Expanded(
                                    child: TextIconButton(
                                        Icon(Icons.info), Text('Info'), () {}))
                              ],
                            )
                          ],
                        ))
                  ],
                ))));
  }
}
