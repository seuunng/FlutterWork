import 'package:calendar_scheduler/component/banner_ad_widget.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/todayBanner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/main.dart';
import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/drift_database.dart';

class HomeScreen extends StatefulWidget {
// const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate,
            ),
            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: (selectedDate, focusedDate) =>
                  onDaySelected(selectedDate, focusedDate, context),
            ),
            SizedBox(height: 8.0),
            // StreamBuilder<List<Schedule>>(
            //     stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            //     builder: (context, snapshot) {
            //       return TodayBanner(
            //           selectedDate: selectedDate,
            //           count: snapshot.data?.length ?? 0,
            //       );
            //     }),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection(
                'schedule',
                )
                .where(
                'date',
                  isEqualTo:
                  '${selectedDate.year}''${selectedDate.month.toString().padLeft(2, '0')}'
                      '${selectedDate.day.toString().padLeft(2, '0')}',
              )
                .snapshots(),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.docs.length ?? 0,
                );
              }
            ),
            SizedBox(height: 8.0),
            // Expanded(
            //     child: StreamBuilder(
            //         stream:
            //             GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            //         builder: (context, snapshot) {
            //           if (!snapshot.hasData) {
            //             return Container();
            //           }
            //           return ListView.builder(
            //             itemCount: snapshot.data!.length,
            //             itemBuilder: (context, index) {
            //               final schedule = snapshot.data![index];
            //               return Dismissible(
            //                 key: ObjectKey(schedule.id),
            //                 direction: DismissDirection.startToEnd,
            //                 onDismissed: (DismissDirection direction) {
            //                   GetIt.I<LocalDatabase>()
            //                       .removeSchedule(schedule.id);
            //                 },
            //                 child: Padding(
            //                   padding: const EdgeInsets.only(
            //                       bottom: 8.0, left: 8.0, right: 8.0),
            //                   child: ScheduleCard(
            //                     startTime: schedule.startTime,
            //                     endTime: schedule.endTime,
            //                     content: schedule.content,
            //                   ),
            //                 ),
            //               );
            //             },
            //           );
            //         }))
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
              .collection(
                'schedule',
              )
              .where(
                'date',
                isEqualTo:
                    '${selectedDate.year}'
                    '${selectedDate.month.toString().padLeft(2, '0')}'
                    '${selectedDate.day.toString().padLeft(2, '0')}',
              )
              .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('일정 정보를 가져오지 못했습니다.'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                final schedules = snapshot.data!.docs
                    .map(
                      (QueryDocumentSnapshot e) =>
                      ScheduleModel.fromJson(
                          json: (e.data() as Map<String, dynamic>)),
                ).toList();

                return ListView.separated(
                  itemCount: schedules.length,
                  separatorBuilder: (context, index) {
                    return BannerAdWidget();
                  },
                  itemBuilder: (context, index) {
                    final schedule = schedules[index];
                    return Dismissible(
                      key: ObjectKey(schedule.id),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (DismissDirection direction) {
                        FirebaseFirestore.instance.collection('schedule')
                            .doc(schedule.id)
                            .delete();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, right: 8.0),
                        child: ScheduleCard(
                          startTime: schedule.startTime,
                          endTime: schedule.endTime,
                          content: schedule.content,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(
      DateTime selectedDate,
      DateTime focusedDate,
      BuildContext context) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
