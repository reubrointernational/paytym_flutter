import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Map<String, double> datamap = {
    "OnTime": 20,
    "Leaves": 8,
    "Late": 2,
    "EarlyOut": 1,
  };
  Color? primaryColor = const Color.fromRGBO(75, 103, 176, 1);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.yellow,
          child: PieChart(
            dataMap: datamap,
            chartRadius:  MediaQuery.of(context).size.width / 3.2,
            chartLegendSpacing: 60,
            colorList: [
              Colors.green,
              Colors.red,
              Colors.blue,
              Colors.yellow,
            ],
            chartValuesOptions: ChartValuesOptions(
              showChartValues: false,
            ),
            legendLabels: <String, String>{
              "OnTime": "On Time : ${datamap["OnTime"]}",
              "Leaves": "Leaves : ${datamap["Leaves"]}",
              "Late": "Late : ${datamap["Late"]}",
              "EarlyOut": "Early Out : ${datamap["EarlyOut"]}"
          }
          ),
        ),
        const SizedBox(height: 10,),
        Text(
            "History",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8,),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index){
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
                          Text(
                            "Date: ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "10-18-2022",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Punch In: ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "09:00 AM",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Punch Out: ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
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
