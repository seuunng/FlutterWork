import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  static final LatLng companyLatLng = LatLng( //지도초기화 위치
    37.85257698328402, // 위도
    127.16272947101038, // 경도
  );
  //지도에 마커 그리기
  static final Marker marker = Marker(
    markerId: MarkerId('company'),
    position: companyLatLng,
  );
  //  지도에 원으로 반경 표시하기
  static final Circle circle = Circle(
    circleId: CircleId('choolCheckCircle'),
    center: companyLatLng,
    fillColor: Colors.blue.withOpacity(0.5),
    radius: 100,
    strokeColor: Colors.blue,
    strokeWidth: 1,
  );

  const HomeScreen({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      //FutureBuilder
      body: FutureBuilder<String>(
        //future
        future: checkPermission(),
        builder: (context, snapshot) {
          //로딩상태
          //snapshot
          if(!snapshot.hasData &&
          snapshot.connectionState == ConnectionState.waiting){
            return Center(
              //CircularProgressIndicator
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data =='위치 권한이 허가 되었습니다.'){
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyLatLng,
                      zoom: 16,
                    ),
                    //  내 위 지도에 보여주기
                    myLocationEnabled: true,
                    //set으로 marker와 circle 제공
                    markers: Set.from([marker]),
                    circles: Set.from([circle]),
                  ),
                ),
                Expanded(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timelapse_outlined,
                          color: Colors.blue,
                          size: 50.0,
                        ),
                        const SizedBox(height: 20.0,),
                        ElevatedButton(
                            onPressed: () async {
                              //  현재위치
                              final curPosition = await Geolocator.getCurrentPosition();
                              final distance = Geolocator.distanceBetween(
                                curPosition.latitude,
                                curPosition.longitude,
                                companyLatLng.latitude,
                                companyLatLng.longitude,
                              );
                              bool canCheck = distance < 100;
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('출근하기'),
                                    content: Text(
                                      canCheck ? '출근을 하시겠습니까?':'출근할 수 없는 위치입니다.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text('취소'),
                                      ),
                                      if (canCheck)
                                        TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text('출근하기'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('츌근하기!'),
                        ),
                      ],
                    ),
                ),
              ],
            );
          }
          //권한이 없는 상태
          return Center(
            child: Text(
              snapshot.data.toString(),
            ),
          );
        }
      ),
    );
  }
  //상단바 디자인
  AppBar renderAppBar() {
      return AppBar(
        centerTitle: true,
        title: Text(
          '오늘도 출첵',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
      );
  }
  //위치 권한 관리하기
  Future<String> checkPermission() async {
    //위치 서비스 활성화 여부 확인
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isLocationEnabled){
      return '위치 서비스를 활성화해주세요.';
    }

    //위치 권한 확인
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if(checkedPermission == LocationPermission.denied){
      checkedPermission = await Geolocator.requestPermission();
    }
    //위치 권한 완전 거절됨, (앱에서 재요청 불가)
    if (checkPermission == LocationPermission.deniedForever) {
      return "앱의 위치 권한을 설정에서 허가해주세요";
    }
    return "위치 권한이 허가 되었습니다.";
  }

}