import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    )
  );
}

