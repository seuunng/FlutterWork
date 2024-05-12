import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState()=>_HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen>{
    final PageController pageController = PageController();
    //페이지 전환 컨트롤러 초기화
  void initState(){//위젯이 생성될 때 한번만 호출됨
    super.initState();

    Timer.periodic( //주기적인 작업반복을 위한 타이머 세팅
        Duration(seconds : 3),
            (timer) {
            int? nextPage=pageController.page?.toInt();
            //pageController.page를 통해 현재 페이지 인덱스를 업고
            if(nextPage==null){
              return;
            }
            if(nextPage==4){
              nextPage=0; //마지막페이지(여기서는 4페이지에 도달하면 0으로 다시 돌아감)
            } else {
              nextPage++;
            }
            pageController.animateToPage(
              //pageController.animateToPage는 지정된 페이지로 부드럽게 애니메이션을 적용하며 이동하는 기능을 수행
              nextPage,
              duration: Duration(milliseconds: 500),
              //페이지 전화에 걸리는 시간
              curve: Curves.ease,
              //페이지 전환시 적용되는 애니메이션 효과: 속도곡선
            );
            },
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    //상태바 스타일 변경
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5] //리스트 생성
            .map((number) => Image.asset(
            'asset/img/image_$number.jpeg',
            fit: BoxFit.cover))
            //Boxfit: 이미지 크기 조정
            //BoxFit.cover: 화면이미지를 꽉차게
            //map() 함수를 이용해서 리스트 요소 이름 변경
            .toList(), //그리고 다시 리스트화
      ),

    );
  }
}

