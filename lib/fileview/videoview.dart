import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/filedescriptors.dart';
import 'package:private_gallery/fileview/texticonbutton.dart';
import 'package:video_player/video_player.dart';

class VideoViewerPage extends StatefulWidget {
  final String heroTag;
  final MyVideo video;
  VideoViewerPage(this.heroTag, this.video);
  _VideoViewerPageState createState() => _VideoViewerPageState();
}

class _VideoViewerPageState extends State<VideoViewerPage> {
  bool appBarVisible = false;
  int currentIndex = 0;
  VideoPlayerController tempController;
  void initState() {
    super.initState();
    print(widget.video.path);
    tempController = VideoPlayerController.asset(
        widget.video.path) // file(widget.video.file)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(false)
      ..initialize().then((value) => tempController.play());
  }

  String parseDuration(Duration duration) {
    int hour = duration.inHours % 24;
    int mint = duration.inMinutes % 60;
    int secd = duration.inSeconds % 60;
    String hr = (hour > 10) ? "$hour:" : "0$hour:";
    String min = (mint > 10) ? "$mint:" : "0$mint:";
    String sec = (secd > 10) ? "$secd" : "0$secd";
    return hr + min + sec;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          tempController.pause();
          return true;
        },
        child: Hero(
            tag: widget.heroTag,
            child: Scaffold(
                appBar:
                    (appBarVisible) ? AppBar(title: Text('file Name')) : null,
                extendBodyBehindAppBar: true,
                body: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        appBarVisible = !appBarVisible;
                      });
                    },
                    onDoubleTap: () {},
                    child: Stack(
                      children: [
                        Center(
                            child: (tempController.value.isInitialized)
                                ? Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          InkWell(
                                            child: AspectRatio(
                                                aspectRatio: tempController
                                                    .value.aspectRatio,
                                                child: VideoPlayer(
                                                    tempController)),
                                            onTap: () {
                                              setState(() {
                                                appBarVisible = !appBarVisible;
                                              });
                                            },
                                          ),
                                          Visibility(
                                            visible: appBarVisible,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            90),
                                                    color: Color.fromARGB(
                                                        50, 0, 0, 0)),
                                                child: IconButton(
                                                  color: Colors.white,
                                                  icon: Icon((tempController
                                                          .value.isPlaying)
                                                      ? Icons.pause
                                                      : Icons.play_arrow),
                                                  onPressed: () {
                                                    if (tempController
                                                        .value.isPlaying)
                                                      tempController.pause();
                                                    else {
                                                      tempController.play();
                                                      setState(() {
                                                        appBarVisible = false;
                                                      });
                                                    }
                                                  },
                                                )),
                                          )
                                        ],
                                      ),
                                      Visibility(
                                          visible: appBarVisible,
                                          child: Container(
                                            color: Theme.of(context).backgroundColor,
                                            child:Row(children: [
                                            Text(parseDuration(
                                                tempController.value.position)),
                                            Expanded(
                                                child: VideoProgressIndicator(
                                              tempController,
                                              allowScrubbing: true,
                                            )),
                                            Text(parseDuration(
                                                tempController.value.duration))
                                          ])))
                                    ],
                                  )
                                : Center(child: CircularProgressIndicator())),
                        Visibility(
                            visible: appBarVisible,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  // bottom sheet like row
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        child: TextIconButton(
                                            Icon(Icons.restore),
                                            Text('Restore'),
                                            () {})),
                                    Expanded(
                                        child: TextIconButton(
                                            Icon(Icons.delete),
                                            Text('Delete'),
                                            () {})),
                                    Expanded(
                                        child: TextIconButton(Icon(Icons.info),
                                            Text('Info'), () {}))
                                  ],
                                )
                              ],
                            ))
                      ],
                    )))));
  }
}
