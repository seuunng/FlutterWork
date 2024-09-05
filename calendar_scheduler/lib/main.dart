  import 'dart:io';

  import 'package:calendar_scheduler/provider/schedule_provider.dart';
  import 'package:calendar_scheduler/repository/schedule_repository.dart';
  import 'package:calendar_scheduler/screen/home_screen.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:google_mobile_ads/google_mobile_ads.dart';
  import 'firebase_options.dart';
  import 'package:flutter/material.dart';
  import 'package:get_it/get_it.dart';
  import 'package:intl/date_symbol_data_local.dart';
  import 'package:calendar_scheduler/database/drift_database.dart';
  import 'package:provider/provider.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // // 플랫폼에 따라 조건부로 ffi 초기화 실행
    // if (Platform.isAndroid || Platform.isIOS) {
    //   // 네이티브 플랫폼에서만 실행되는 코드
    //   initFfi();
    // } else {
    //   // 웹에서는 이 코드를 실행하지 않음
    //   print("Web environment: skipping ffi initialization.");
    // }

    MobileAds.instance.initialize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await initializeDateFormatting();

    // final database = LocalDatabase();
    //
    // GetIt.I.registerSingleton<LocalDatabase>(database);
    //
    // final repository = ScheduleRepository();
    // final scheduleProvider = ScheduleProvider(repository: repository);
    runApp(
        // ChangeNotifierProvider(
        //   create: (_) => scheduleProvider,
        //   child: MaterialApp(
        //     home: HomeScreen(),
        //   ),
        // )
        MaterialApp(debugShowCheckedModeBanner: false,
            home: HomeScreen()));
  }
