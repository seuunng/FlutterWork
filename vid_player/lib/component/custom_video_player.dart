import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io'; //파일 관련 작업 패키지
import 'package:vid_player/component/custom_icon_button.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video,
    required this.onNewVideoPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  bool showControls = false;
  bool doYouWantFastPlaying = false;

  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  initializeController() async {
    //선택한 동영상으로 컨트롤러 초기화
    final videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoController.initialize();
    videoController.addListener(videoControllerListener);
    setState(() {
      this.videoController = videoController;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack(
          //children위젯을 위로 쌓을 수 있는 위젯
          children: [
            VideoPlayer(
              //VideoPlayer위젯을 Stack으로 이동
              videoController!,
            ),
            if (showControls)
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            Positioned(
              //child의 위젯의 위치를 정할 수 있는 위젯
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    renderTimeTextFromDuration(
                      videoController!.value.position,
                    ),
                    Expanded(
                      child: Slider(
                        //동영상 재생 상태를 보여주는 슬라이더
                        onChanged: (double val) {
                          //슬라이더가 움직일 때 마다 실행할 함수
                          videoController!.seekTo(
                            Duration(seconds: val.toInt()),
                          );
                        },
                        //동영상 재생 위치를 초 단위로 표현
                        value: videoController!.value.position.inSeconds
                            .toDouble(),
                        min: 0,
                        max: videoController!.value.duration.inSeconds
                            .toDouble(),
                      ),
                    ),
                    renderTimeTextFromDuration(
                      videoController!.value.duration,
                    ),
                  ],
                ),
              ),
            ),
            if (showControls)
              Align(
                alignment: Alignment.topRight,
                child: Row(
                children: [
                 CustomIconButton(
                  onPressed: widget.onNewVideoPressed,
                  iconData: Icons.photo_camera_back,
                ),
                  CustomIconButton(
                    onPressed: onPlayFast,
                    iconData: Icons.speed,
                  ),
                ]
              ),
              ),
            if (showControls)
              Align(
                //동영상 재생 관련 아이콘 중앙에 위치
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    CustomIconButton(
                      onPressed: onPlayPressed,
                      iconData: videoController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    CustomIconButton(
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;
    Duration position = Duration();
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  void onPlayFast() {
      if(!doYouWantFastPlaying){
        videoController!.setPlaybackSpeed(2.0);
      } else {
        videoController!.setPlaybackSpeed(1.0);
      }
      doYouWantFastPlaying = !doYouWantFastPlaying;
  }

  void onForwardPressed() {
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;
    Duration position = maxPosition;
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  // 동영상의 재생상태가 변경될 때마다
  // setState()를 실행해서 build()를 재실행 합니다.
  void videoControllerListener() {
    setState(() {});
  }

  @override
  void dispose() {
    //스테이트가 폐기돌때 같이 폐기할 함수들을 실행
    //listener삭제
    videoController?.removeListener(videoControllerListener);
    super.dispose();
  }

  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
      '${duration.inHours.toString().padLeft(2, '0')}:'
      '${duration.inMinutes.toString().padLeft(2, '0')}:'
      '${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
