import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? controller; //컨트롤러 변수 생성
  HomeScreen({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //상단바
        backgroundColor: Colors.orange,
        title: Text('Code Factory'),
        centerTitle: true,
        //앱바의 액션 매개변수
        actions: [
          //아이콘 버튼을 누르면 함수 실행
          IconButton(onPressed: () {
            if (controller != null) {
              controller!.loadUrl('https://blog.codefactory.ai');
            }
          }, icon: Icon( //홈버튼 아이콘
            Icons.home,
          ))
        ],
      ),
      body: WebView(
        //웹뷰 생성 함수
        onWebViewCreated: (WebViewController controller){
          //위젯의 인스턴스를 제어하기 위한 컨트롤러
          //controller가 null이 아님을 보장하고 그에 따른 메소드를 호출
          //controller 변수가 null일 가능성이 있지만,
          //이 코드 라인이 실행되는 시점에서는 null이 아닐 것임을 개발자가 확신하는 경우 사용
          this.controller = controller;
        },
        initialUrl: 'https://blog.codefactory.ai',
        javascriptMode: JavascriptMode.unrestricted,
        //WebView 내에서 자바스크립트 코드가 제한 없이 실행될 수 있도록 허용
      ),
    );
  }

}