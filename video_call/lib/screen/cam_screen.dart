import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CamScreen extends StatefulWidget{
  const CamScreen({Key? key}):super(key:key);

  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen>{
  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();
    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if(cameraPermission != PermissionStatus.granted ||
    micPermission != PermissionStatus.granted) {
      throw "카메라 또는 마이크 권한이 없습니다.";
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      // 위젯 렌더링
      body: FutureBuilder(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //퓨처 실행후 에러가 있을때
          if(snapshot.hasError){
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          //퓨처실행후 아직 데이터가 없을때
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        //나머지 상황에 권한 있을 표시
        return Center(
          child: Text('모든 권한이 있습니다!'),
        );
        }
      ),
    );
  }
}