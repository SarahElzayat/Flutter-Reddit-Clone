///@author: Yasmine Ghanem
///@date:
///this screen shows the traffic stats of the subreddit

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tab_container/tab_container.dart';

class TrafficStats extends StatefulWidget {
  const TrafficStats({super.key});

  @override
  State<TrafficStats> createState() => _TrafficStatsState();
}

class _TrafficStatsState extends State<TrafficStats> {
  final ScrollController verticalController = ScrollController();
  final TabContainerController tabController =
      TabContainerController(length: 3);

  @override
  void initState() {
    ModerationCubit.get(context).getTrafficStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        ModerationCubit cubit = ModerationCubit.get(context);
        // cubit.getTrafficStats();
        return cubit.trafficStats == null
            ? Container()
            : Scrollbar(
                controller: verticalController,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: verticalController,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Traffic stats ',
                                  style: TextStyle(
                                      color: ColorManager.eggshellWhite,
                                      fontSize: 16.sp)),
                              Text('updating every hour',
                                  style: TextStyle(
                                      color: ColorManager.eggshellWhite,
                                      fontSize: 12.sp))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 75.w,
                          child: AspectRatio(
                            aspectRatio: 10 / 8,
                            child: TabContainer(
                                colors: const <Color>[
                                  ColorManager.betterDarkGrey,
                                  ColorManager.betterDarkGrey,
                                  ColorManager.betterDarkGrey,
                                ],
                                tabs: const ['Month', 'Week', 'Days'],
                                tabEdge: TabEdge.top,
                                radius: 20,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: trafficStatsContainer(
                                                cubit.trafficStats!
                                                    .numberOfJoinedLastDay!,
                                                '24 HOURS'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: trafficStatsContainer(
                                                cubit.trafficStats!
                                                    .numberOfJoinedLastWeek!,
                                                '7 DAYS'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: trafficStatsContainer(
                                                cubit.trafficStats!
                                                    .numberOfJoinedLastMonth!,
                                                'MONTH'),
                                          )
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: AspectRatio(
                                            aspectRatio: 2,
                                            child: LineChart(
                                              LineChartData(
                                                  titlesData: FlTitlesData(
                                                      rightTitles: AxisTitles(
                                                          axisNameWidget:
                                                              const Text('')),
                                                      topTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false),
                                                      ),
                                                      bottomTitles: AxisTitles(
                                                          sideTitles:
                                                              SideTitles(
                                                                  getTitlesWidget:
                                                                      ((value, meta) {
                                                                    switch (value
                                                                        as int) {
                                                                      case 1:
                                                                        return const Text(
                                                                            'Jan');

                                                                      case 2:
                                                                        return const Text(
                                                                            'Feb');
                                                                      case 3:
                                                                        return const Text(
                                                                            'Mar');
                                                                      case 4:
                                                                        return const Text(
                                                                            'Apr');
                                                                      case 5:
                                                                        return const Text(
                                                                            'May');
                                                                      case 6:
                                                                        return const Text(
                                                                            'Jun');
                                                                      case 7:
                                                                        return const Text(
                                                                            'Jul');
                                                                      case 8:
                                                                        return const Text(
                                                                            'Aug');
                                                                      case 9:
                                                                        return const Text(
                                                                            'Sep');
                                                                      case 10:
                                                                        return const Text(
                                                                            'Oct');
                                                                      case 11:
                                                                        return const Text(
                                                                            'Nov');

                                                                      default:
                                                                        return const Text(
                                                                            'Dec');
                                                                    }
                                                                  }),
                                                                  interval: 1,
                                                                  showTitles: true),
                                                          axisNameWidget: const Text('Month'))),
                                                  gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: true),
                                                  minX: 1,
                                                  maxX: 12,
                                                  lineBarsData: [
                                                    LineChartBarData(
                                                        spots: getMonthSpot(
                                                            cubit.trafficStats!
                                                                .months))
                                                  ]),
                                            ),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: trafficStatsContainer(
                                                cubit.trafficStats!
                                                    .numberOfJoinedLastDay!,
                                                '24 HOURS'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: trafficStatsContainer(
                                                cubit.trafficStats!
                                                    .numberOfJoinedLastWeek!,
                                                '7 DAYS'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: trafficStatsContainer(
                                                cubit.trafficStats!
                                                    .numberOfJoinedLastMonth!,
                                                'MONTH'),
                                          )
                                        ],
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: AspectRatio(
                                            aspectRatio: 2,
                                            child: LineChart(
                                              LineChartData(
                                                  titlesData: FlTitlesData(
                                                      rightTitles: AxisTitles(
                                                          axisNameWidget:
                                                              const Text('')),
                                                      topTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false),
                                                      ),
                                                      bottomTitles: AxisTitles(
                                                          sideTitles:
                                                              SideTitles(
                                                                  getTitlesWidget:
                                                                      ((value, meta) {
                                                                    switch (value
                                                                        as int) {
                                                                      case 1:
                                                                        return const Text(
                                                                            'Friday');
                                                                      case 2:
                                                                        return const Text(
                                                                            'Thursday');
                                                                      case 3:
                                                                        return const Text(
                                                                            'Wednesday');
                                                                      case 4:
                                                                        return const Text(
                                                                            'Tuesday');
                                                                      case 5:
                                                                        return const Text(
                                                                            'Monday');
                                                                      case 6:
                                                                        return const Text(
                                                                            'Sunday');
                                                                      default:
                                                                        return const Text(
                                                                            'Saturday');
                                                                    }
                                                                  }),
                                                                  interval: 1,
                                                                  showTitles: true),
                                                          axisNameWidget: const Text('Week Day'))),
                                                  gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: true),
                                                  minX: 1,
                                                  maxX: 7,
                                                  lineBarsData: [
                                                    LineChartBarData(
                                                        spots: getWeekSpot(cubit
                                                            .trafficStats!
                                                            .weeks))
                                                  ]),
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 60.h,
                                    height: 40.h,
                                    child: const Text('Data incorrect'),
                                  ),
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          width: 75.w,
                          child: AspectRatio(
                            aspectRatio: 0.6,
                            child: TabContainer(
                                colors: const <Color>[
                                  ColorManager.betterDarkGrey,
                                  ColorManager.betterDarkGrey,
                                  ColorManager.betterDarkGrey,
                                ],
                                tabs: const ['Days', 'Weeks', 'Month'],
                                tabEdge: TabEdge.top,
                                radius: 20,
                                children: [
                                  SizedBox(
                                    width: 80.w,
                                    child: DataTable(
                                        border: TableBorder.all(
                                            color: ColorManager.textGrey),
                                        columns: [
                                          DataColumn(
                                              label: Text(
                                            'DAY',
                                            style: TextStyle(
                                                color:
                                                    ColorManager.eggshellWhite,
                                                fontSize: 10.sp),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'MEMBERS JOINED',
                                            style: TextStyle(
                                                color:
                                                    ColorManager.eggshellWhite,
                                                fontSize: 10.sp),
                                          ))
                                        ],
                                        rows: getDaysRows(
                                            cubit.trafficStats!.days)),
                                  ),
                                  SizedBox(
                                    width: 80.w,
                                    child: DataTable(
                                        border: TableBorder.all(
                                            color: ColorManager.textGrey),
                                        columns: [
                                          DataColumn(
                                              label: Text(
                                            'DAY',
                                            style: TextStyle(
                                                color:
                                                    ColorManager.eggshellWhite,
                                                fontSize: 10.sp),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'MEMBERS JOINED',
                                            style: TextStyle(
                                                color:
                                                    ColorManager.eggshellWhite,
                                                fontSize: 10.sp),
                                          ))
                                        ],
                                        rows: getWeekRows(
                                            cubit.trafficStats!.weeks)),
                                  ),
                                  SizedBox(
                                    width: 80.w,
                                    child: DataTable(
                                        border: TableBorder.all(
                                            color: ColorManager.textGrey),
                                        columns: [
                                          DataColumn(
                                              label: Text(
                                            'DAY',
                                            style: TextStyle(
                                                color:
                                                    ColorManager.eggshellWhite,
                                                fontSize: 10.sp),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'MEMBERS JOINED',
                                            style: TextStyle(
                                                color:
                                                    ColorManager.eggshellWhite,
                                                fontSize: 10.sp),
                                          ))
                                        ],
                                        rows: getMonthRows(
                                            cubit.trafficStats!.months)),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  List<FlSpot> getWeekSpot(list) {
    List<FlSpot> graph = [];
    for (int i = 0; i < list.length; i++) {
      graph.add(FlSpot(i + 1, list[i].numberOfJoined));
    }
    return graph;
  }

  List<FlSpot> getMonthSpot(list) {
    List<FlSpot> graph = [];
    for (int i = 0; i < list.length; i++) {
      graph.add(FlSpot(i + 1, list[11 - i].numberOfJoined));
    }
    return graph;
  }

  List<DataRow> getDaysRows(list) {
    List<DataRow> rows = [];
    for (int i = 0; i < list.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text('${list[i].day.substring(0, 9)}')),
        DataCell(Text('${list[i].numberOfJoined}'))
      ]));
    }
    return rows;
  }

  List<DataRow> getWeekRows(list) {
    List<DataRow> rows = [];
    for (int i = 0; i < list.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text('${list[i].day}')),
        DataCell(Text('${list[i].numberOfJoined}'))
      ]));
    }
    return rows;
  }

  List<DataRow> getMonthRows(list) {
    List<DataRow> rows = [];
    for (int i = 0; i < list.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text('${list[i].month}')),
        DataCell(Text('${list[i].numberOfJoined}'))
      ]));
    }
    return rows;
  }

  Widget trafficStatsContainer(int number, String time) => Container(
        width: 18.w,
        height: 14.h,
        decoration: BoxDecoration(
            color: ColorManager.betterDarkGrey,
            border: Border.all(color: ColorManager.textGrey),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('$number',
                  style: TextStyle(
                    color: ColorManager.eggshellWhite,
                    fontSize: 16.sp,
                  )),
            ),
            Text('TOTAL - LAST $time',
                style: TextStyle(
                  color: ColorManager.textGrey,
                  fontSize: 10.sp,
                ))
          ]),
        ),
      );
}
