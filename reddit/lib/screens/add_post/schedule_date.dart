import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';

class ScheduleDate extends StatefulWidget {
  ScheduleDate({Key? key}) : super(key: key);

  @override
  State<ScheduleDate> createState() => _ScheduleDateState();
}

class _ScheduleDateState extends State<ScheduleDate> {
  late DateTime dateTime;

  late TimeOfDay timeOfDay;

  DateTime? finalDate;

  @override
  void initState() {
    // TODO: implement initState
    finalDate = AddPostCubit.get(context).scheduleDate;
    if (finalDate != null) {
      dateTime = finalDate!;
      timeOfDay = TimeOfDay(hour: finalDate!.hour, minute: finalDate!.minute);
    } else {
      dateTime = DateTime.now();
      timeOfDay =
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addPostCubit = AddPostCubit.get(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Post'),
        actions: [
          TextButton(
              onPressed: () {
                finalDate = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day,
                    timeOfDay.hour,
                    timeOfDay.minute,
                    dateTime.second);
                addPostCubit.scheduleDate = finalDate;
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: ColorManager.blue,
                    fontSize: 19 * mediaQuery.textScaleFactor),
              ))
        ],
      ),
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Starts',
                style: TextStyle(fontSize: 18 * mediaQuery.textScaleFactor),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: (() async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          builder: ((context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: Colors.blueAccent, // <-- SEE HERE
                                  onPrimary: ColorManager
                                      .eggshellWhite, // <-- SEE HERE
                                  onSurface: ColorManager
                                      .eggshellWhite, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary:
                                        Colors.blueAccent, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          }));

                      if (newDate != null) {
                        setState(() {
                          // finalDate = newDate;
                          dateTime = DateTime(newDate.year, newDate.month,
                              newDate.day, timeOfDay.hour, timeOfDay.minute);
                        });
                      }
                    }),
                    child: Text(
                      DateFormat('MMM, dd, yyyy').format(dateTime),
                      style:
                          TextStyle(fontSize: 17 * mediaQuery.textScaleFactor),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      TimeOfDay? newTimeOfDay = await showTimePicker(
                          builder: (context, child) {
                            return Theme(
                                data: Theme.of(context).copyWith(
                                    timePickerTheme: const TimePickerThemeData(
                                        dialHandColor: Colors.orange,
                                        backgroundColor: Colors.blueGrey,
                                        hourMinuteShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          side: BorderSide(
                                              color: Colors.orange, width: 4),
                                        ))),
                                child: child!);
                          },
                          context: context,
                          initialTime: TimeOfDay(
                              hour: dateTime.hour, minute: dateTime.minute));
                      if (newTimeOfDay != null) {
                        setState(() {
                          dateTime = DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              newTimeOfDay.hour,
                              newTimeOfDay.minute);
                          timeOfDay = newTimeOfDay;
                        });
                      }
                    },
                    child: Text(
                      DateFormat('hh:mm a').format(dateTime),
                      style:
                          TextStyle(fontSize: 17 * mediaQuery.textScaleFactor),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
