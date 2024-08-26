import 'package:flutter/material.dart';

void main() {
  runApp(SplashScreen()); //SplashScreen 위젯을 첫화면으로 지정
}

class SplashScreen extends StatelessWidget {
  //StatelessWidget 선언
  @override
  Widget build(BuildContext context) {
    //위젯의 UI 구현
    return MaterialApp(
      //MaterialApp: 항상 최상단에 입력되는 위젯
      home: Scaffold(
        //Scaffold: 항상 두번째로 입력되는 위젯
        body: Container(
          //Container: 기본 컨테이너 위젯
          decoration: BoxDecoration(
            //decoration: 컨테이너를 디자인하기 위한 네임드 파라미터
            //BoxDecoration: 매게변수를 통해 컨테이너의 여러 UI적 요소를 지정한다.
            color: //Colors.orange,
                Color(
                    0xFFF99231), //헥스코드를 색상으로 사용하기위한 클래스 0x:16진수, FF:불투명도100% #생략한 6자리 헥스코드
          ),
          child: //Center(
              //Center: 중앙 정렬 위젯
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                //가운데 정렬 추가
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //children: 여러 위젯을 입력할 수 있는 매개변수
                  //Text('Splash Screen') //Text: 글자를 화면에 보여주는 위젯
                  Image.asset(
                    'assets/logo.png',
                    width: 200, //width:  너비 추가
                  ),
                  CircularProgressIndicator( //CircularProgressIndicator: 동그랗게 빙그빙글도는 로딩 위젯
                    valueColor: AlwaysStoppedAnimation( //valueColor: 애니메이션 색상 매개변수
                      Colors.white, //대부분 그냥 Color나 Colors로 색을 변경할 수 있지만, 색상에 애니매이션이 적용되야 하므로  AlwaysStoppedAnimation으로 감싸서 색상을 제공한다.
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
