import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileview/texticonbutton.dart';

class VideoViewerPage extends StatefulWidget {
  final String heroTag;
  final PageController controller;
  VideoViewerPage(this.heroTag,this.controller);
  _VideoViewerPageState createState() => _VideoViewerPageState();
}

class _VideoViewerPageState extends State<VideoViewerPage> {
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
                onDoubleTap: () {},
                child: Stack(
                  children: [
                    Center(
                      child: PageView(
                        controller: widget.controller,
                        onPageChanged: (index){
                          currentIndex = index;
                        },
                        children: [  // must be from file controller
                          Image.asset("assets/images/private_gallery_icon.png"),
                          Image.asset("assets/images/private_gallery_icon.png"),
                          Image.asset("assets/images/private_gallery_icon.png"),
                          Image.asset("assets/images/private_gallery_icon.png"),
                          Image.asset("assets/images/private_gallery_icon.png"),
                          Image.asset("assets/images/private_gallery_icon.png"),
                          Image.asset("assets/images/private_gallery_icon.png"),
                          Image.asset("assets/images/private_gallery_icon.png")
                        ],
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
