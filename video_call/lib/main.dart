import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_call/screen/home_screen.dart';

void main(){
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
/*
late List<CameraDescription> _cameras;

Future<void> main() async {
  //Flutter앱이 실행될 준비가 됐는지 확인
  WidgetsFlutterBinding.ensureInitialized();

  //핸드폰에 있는 카메라들 가져오기
  _cameras = await availableCameras();
  runApp(const CameraApp());
}
class CameraApp extends StatefulWidget{
  const CameraApp({Key? key}):super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp>{
  //카메라를 제어할 수 있는 컨트롤러 선언
  late CameraController controller;

  @override
  void initState(){
    super.initState();
    initializeCamera();
  }

  initializeCamera() async {
    try{
      //가장 첫번째 카메라로 카메라 설정하기
      controller = CameraController(_cameras[0], ResolutionPreset.max);
      //카메라 초기화
      await controller.initialize();

      setState(() {});
    } catch(e){
      //에러났을떄 출력
      if(e is CameraException){
        switch(e.code){
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
      void dispose(){
        //컨튼롤러 삭제
        controller.dispose();
        super.dispose();
      }
      Widget build(BuildContext context){
        //카메라 초기화 상태 확인
        if(!controller.value.isInitialized){
          return Container();
        }
        return MaterialApp(
          //카메라 보여주기
          home: CameraPreview(controller),
        );
      }
    }
  }
}
*/
