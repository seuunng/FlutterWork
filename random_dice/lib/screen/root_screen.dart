import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/root_screen.dart';
import 'package:random_dice/screen/setting_screen.dart';
import 'dart:math';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}):super(key: key);
  @override
  State<StatefulWidget> createState() => _RootScreenState();

  }
  class _RootScreenState extends State<RootScreen> with
TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;
  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
    controller!.addListener(tabListener);//컨트롤러 속성이 변경될 때 마다 실행할 함수 등록

    shakeDetector=ShakeDetector.autoStart(
        onPhoneShake: onPhoneShake,
      shakeSlopTimeMS: 100,
      shakeThresholdGravity: threshold,
      );
  }
  void tabListener() {
    setState(() {

    });
  }
  @override
  void dispose() {
    controller!.removeListener(tabListener);
    shakeDetector!.stopListening();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }
  List<Widget> renderChildren(){
    return [
      HomeScreen(number: number),
      SettingScreen(
          threshold: threshold,
          onThresholdChange: onThresholdChange,)
    ];
  }
  BottomNavigationBar renderBottomNavigation(){
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index){
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
      BottomNavigationBarItem(icon: Icon(
        Icons.edgesensor_high_outlined,
      ),
      label: '주사위',
      ),
      BottomNavigationBarItem(icon: Icon(
        Icons.settings,
      ),
      label: '설정',
      ),
    ],
    );
  }



  void onThresholdChange(double val) {
    setState(() {
      threshold=val;
    });
  }

  void onPhoneShake() {
    final rand = new Random();
    setState(() {
      number = rand.nextInt(5)+1;
    });
  }
}