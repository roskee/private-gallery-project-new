import 'package:flutter/material.dart';
import 'package:private_gallery/fileio/filedescriptors.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerPage extends StatefulWidget{
  final MyVideo video;
  VideoPlayerPage(this.video);
  VideoPlayerState createState() => VideoPlayerState();
}
class VideoPlayerState extends State<VideoPlayerPage>{
  VideoPlayerController tempController;
  bool playerIconVisible = true;
  VideoPlayerState();
  @override
  void initState(){
    super.initState();
    print(widget.video.path);
    tempController = VideoPlayerController.asset(widget.video.path) // file(widget.video.file)
      ..addListener(() {
        print('video ready');
        setState((){
        });
      })
      ..setLooping(false)
      ..initialize();
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
  @override
  void dispose(){
    tempController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        tempController.pause();
        return true;
      },
      child:Container(
        color: Colors.transparent,
        child: Center(
            child: (tempController.value.isInitialized)
                ? Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          InkWell(
                            child: AspectRatio(
                                aspectRatio: tempController.value.aspectRatio,
                                child: VideoPlayer(tempController)),
                            onTap: () {
                              setState(() {
                                playerIconVisible = !playerIconVisible;
                              });
                            },
                          ),
                          Visibility(
                            visible: playerIconVisible,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90),
                                    color: Color.fromARGB(50, 0, 0, 0)),
                                child: IconButton(
                                  color: Colors.white,
                                  icon: Icon((tempController.value.isPlaying)
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  onPressed: () {
                                    if (tempController.value.isPlaying)
                                      tempController.pause();
                                    else
                                      tempController.play();
                                  },
                                )),
                          )
                        ],
                      ),
                      Visibility(
                          visible: playerIconVisible,
                          child: Row(children: [
                            Text(parseDuration(tempController.value.position)),
                            Expanded(
                                child: VideoProgressIndicator(
                              tempController,
                              allowScrubbing: true,
                            )),
                            Text(parseDuration(tempController.value.duration))
                          ]))
                    ],
                  )
                : Center(
                  child:CircularProgressIndicator())
                  ))
    );
  }

}