// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../login/login_controller.dart';
//
// class NextShiftPage extends GetView<NextShiftController> {
//   const NextShiftPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(NextShiftController());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Next Shift Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Trigger the method to get data when the button is pressed
//             controller.getData23().then((dashboardData) {
//               // Show an alert dialog with the details from the map
//               Get.defaultDialog(
//                 title: 'Dashboard Details',
//                 content: Column(
//                   children: [
//                     Text('Message: ${dashboardData['message']}'),
//                     Text('Casual: ${dashboardData['casual']}'),
//                     // Add more fields as needed...
//                   ],
//                 ),
//                 confirm: ElevatedButton(
//                   onPressed: () {
//                     // Close the alert dialog
//                     Get.back();
//                   },
//                   child: Text('Close'),
//                 ),
//               );
//             }).catchError((error) {
//               // Handle error if fetching data fails
//               print('Error: $error');
//               // Optionally, show an error message
//               Get.snackbar('Error', 'Failed to load data');
//             });
//           },
//          child: Text(''),
//         ),
//       ),
//     );
//   }
// }
//
// class NextShiftController extends GetxController {
//   Future<Map<String, dynamic>> getData23() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://paytym.net/api/dashboard'),
//         headers: {
//           'Authorization':
//           'Bearer ${Get.find<LoginController>().loginResponseModel?.token}'
//         },
//       );
//       print('Response: ${response.body}');
//
//       if (response.statusCode == 200) {
//         Map<String, dynamic> responseData = jsonDecode(response.body);
//
//
//
//         // Extract the specific fields you need from the new API response
//         Map<String, dynamic> dashboardData = {
//           'message': responseData['message'],
//           'casual': responseData['casual'],
//           'absence': responseData['absence'],
//           'annual': responseData['annual'],
//           'halfday': responseData['halfday'],
//           'sick': responseData['sick'],
//           'late_arrival': responseData['late_arrival'],
//           'total_work_days': responseData['total_work_days'],
//           'hours': responseData['hours'],
//           'roster_check_in_time': responseData['roster_check_in_time'],
//           'next_shift': responseData['next shift'],
//           'last_checked_in': responseData['last_checked_in'],
//           'allowed_absent': responseData['allowed_absent'],
//           'allowed_sick_leave': responseData['allowed_sick_leave'],
//           'allowed_annual_leave': responseData['allowed_annual_leave'],
//           'allowed_late_arrival': responseData['allowed_late_arrival'],
//         };
//
//         print("Dashboard Data: $dashboardData");
//         return dashboardData;
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (error) {
//       print('Error: $error');
//       throw error;
//     }
//   }
// }
