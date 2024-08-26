import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[100],
        body: SafeArea(
          //시스템 UI 피해서 UI 그리기
          top: true,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //위아래 끝에 위젯 배치
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //반축 최대 크기로 늘리기
            children: [
              _DDay(
                onHeartPressed: onHeartPressed,
                firstDay: firstDay,
              ),
              _CoupleImage(),
            ],
          ),
        ));
  }

  void onHeartPressed() {
    //상태 변경 시 setState() 함수 실행
    setState(() {
      //firstDay변수에서 하루 빼기
      //firstDay = firstDay.subtract(Duration(days: 1));
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Align( //정렬지정하는 위젯
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                //날짜 선택하는 다이어로그
                mode: CupertinoDatePickerMode.date,
                //시간 제외하고 날짜만 선택하기
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    firstDay = date;
                  });
                },
              ),
            ),
          );
        },
        barrierDismissible: true, //외부 탭할 경우 다이얼로그 닫기
      );
    });
  }
}

class _DDay extends StatelessWidget {
  final GestureTapCallback onHeartPressed;
  final DateTime firstDay;

  _DDay({
    required this.onHeartPressed,
    required this.firstDay,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    final int dDay = DateTime(now.year, now.month, now.day).difference(firstDay).inDays;
    String dDayText = dDay <0 ? 'D-${-dDay}': 'D+${dDay+1}';
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          'U&I',
          style: textTheme.displayLarge,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          '우리처음만난날',
          style: textTheme.bodyLarge,
        ),
        Text(
          //'2921.11.23.',
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          //처음만난날의 년.월.일. 형태로 변경
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16.0),
        IconButton(
          iconSize: 60.0,
          onPressed: onHeartPressed,
          icon: Icon(
            Icons.favorite,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          //'D+365',
          dDayText,
          //디데이계산하기
          style: textTheme.displayMedium,
        )
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'asset/img/middle_image.png',
          height: MediaQuery.of(context).size.height / 2,
          //Expanded가 우선순위를 갖게 되어 무시됩니다.
          //화면의 반만큼 높이 구현
        ),
      ),
    );
  }
}
