import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet>{
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: CustomTextField(
                        label: '시작 시간',
                        isTime: true,
                      ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(child: CustomTextField(
                        label: '종료시간',
                        isTime: true,
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Expanded(
                    child: CustomTextField(
                      label: '내용',
                      isTime: false,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: onSavePressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          textStyle: TextStyle(
                            color: Colors.white, // 글자 색상 하얀색으로 설정
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0), // 모서리를 둥글게 하지 않음
                          ),
                        ),
                        child: Text(
                          '저장',
                          style: TextStyle(color: Colors.white),)
                    ),
                  )
                ],
              )
          )
      ),
    );
  }
    void onSavePressed(){

    }

}