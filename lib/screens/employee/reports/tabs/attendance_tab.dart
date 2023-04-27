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

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() {
        if (Get.find<ReportsController>()
                .attendanceResponseModel
                .value
                .history !=
            null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PieChart(
                  dataMap: Get.find<ReportsController>().pieChartData,
                  chartRadius: w / 3.2,
                  chartLegendSpacing: 60,
                  colorList: CustomColors.cardColorList,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValues: false,
                  ),
                  legendLabels: <String, String>{
                    "OnTime":
                        "On Time : ${Get.find<ReportsController>().pieChartData["OnTime"]}",
                    "Leaves":
                        "Leaves : ${Get.find<ReportsController>().pieChartData["Leaves"]}",
                    "Late":
                        "Late : ${Get.find<ReportsController>().pieChartData["Late"]}",
                    "EarlyOut":
                        "Early Out : ${Get.find<ReportsController>().pieChartData["EarlyOut"]}"
                  }),
              kSizedBoxH10,
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  kHistoryString,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              kSizedBoxH8,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Get.find<ReportsController>()
                    .attendanceResponseModel
                    .value
                    .history!
                    .length,
                itemBuilder: (context, index) {
                  final history = Get.find<ReportsController>()
                      .attendanceResponseModel
                      .value
                      .history![index];
                  return Card(
                    elevation: 4,
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
                                Get.find<ReportsController>()
                                    .getDate(history.date.toString()),
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
                                Get.find<ReportsController>()
                                    .getTime(history.checkIn.toString()),
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
          );
        }
        return Container();
      }),
    );
  }
}
