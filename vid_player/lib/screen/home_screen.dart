import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) :super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; //동영상 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //동영상이 선택됐을때와 선택 안됐을떄 보여줄 위젯
      body: video == null?  renderEmpty(): renderVideo(),
    );
  }
//동영상 선택 전 보여줄 위젯
 Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        //위젯들 가운데 정렬
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo( //로고이미지
            onTap: onNewVideoPressed, //로고 탭하면 실행하는 함수
          ),
          SizedBox(height: 30.0,),
          _AppName(), //앱이름

        ],
      ),
    );
 }
 void onNewVideoPressed() async {  //이미지 선택하는 기능을 구현한 함수
    final video = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
    );

    if (video != null){
      setState(() {
        this.video = video;
      });
    }
 }
BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient( //그라데이션
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
}

//동영상 선택후 보여줄 위젯
 Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  }



class _Logo extends StatelessWidget {//로고를 보여줄 위젯
  final GestureTapCallback onTap;

  const _Logo({
    required this.onTap,
    Key? key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
      child: Image.asset(
      'asset/img/logo.png'
      ),
    );
  }

}
class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,

    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          )
        )
      ],
    );
  }
}


