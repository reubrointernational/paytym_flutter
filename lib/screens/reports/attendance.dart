import 'package:flutter/material.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../core/constants/strings.dart';
import '../../core/constants/styles.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PieChart(
            dataMap: datamap,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            chartLegendSpacing: 60,
            colorList: CustomColors.cardColorList,
            chartValuesOptions: const ChartValuesOptions(
              showChartValues: false,
            ),
            legendLabels: <String, String>{
              "OnTime": "On Time : ${datamap["OnTime"]}",
              "Leaves": "Leaves : ${datamap["Leaves"]}",
              "Late": "Late : ${datamap["Late"]}",
              "EarlyOut": "Early Out : ${datamap["EarlyOut"]}"
            }),
        kSizedBoxH10,
        const Text(
          kHistoryString,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        kSizedBoxH8,
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            kDateString,
                            style: kTextStyleS12W600Cblue,
                          ),
                          Text(
                            "10-18-2022",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      kSizedBoxH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            kPunchInString,
                            style: kTextStyleS12W600Cblue,
                          ),
                          Text(
                            "09:00 AM",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      kSizedBoxH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            kPunchOutString,
                            style: kTextStyleS12W600Cblue,
                          ),
                          Text(
                            "05:20 PM",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
