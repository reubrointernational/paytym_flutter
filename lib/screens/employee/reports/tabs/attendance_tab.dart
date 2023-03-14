import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employee/reports/reports_controller.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/constants/styles.dart';

class AttendanceTab extends StatelessWidget {
  const AttendanceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.find<ReportsController>().getAttendance());
    var attendance = Get.put(ReportsController());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PieChart(
              dataMap: attendance.pieChartData,
              chartRadius: w / 3.2,
              chartLegendSpacing: 60,
              colorList: CustomColors.cardColorList,
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: false,
              ),
              legendLabels: <String, String>{
                "OnTime": "On Time : ${attendance.pieChartData["OnTime"]}",
                "Leaves": "Leaves : ${attendance.pieChartData["Leaves"]}",
                "Late": "Late : ${attendance.pieChartData["Late"]}",
                "EarlyOut": "Early Out : ${attendance.pieChartData["EarlyOut"]}"
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
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: attendance.attendanceResponseModel.value.history!.length,
            itemBuilder: (context, index) {
              final history =
                  attendance.attendanceResponseModel.value.history![index];
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
                        children: [
                          const Text(
                            kDateString,
                            style: kTextStyleS12W600Cblue,
                          ),
                          Text(
                            attendance.getDate(history.date.toString()),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      kSizedBoxH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            kPunchInString,
                            style: kTextStyleS12W600Cblue,
                          ),
                          Text(
                            history.checkIn != null
                                ? attendance.getTime(history.checkIn.toString())
                                : '00:00',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      kSizedBoxH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            kPunchOutString,
                            style: kTextStyleS12W600Cblue,
                          ),
                          Text(
                            history.checkOut != null
                                ? attendance
                                    .getTime(history.checkOut.toString())
                                : "00:00",
                            style: const TextStyle(
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
        ],
      ),
    );
  }
}
