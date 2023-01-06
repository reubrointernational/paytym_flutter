// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../core/colors/colors.dart';
// import '../../../core/constants/strings.dart';
// import '../../../routes/app_routes.dart';

// class HRDashboardLists extends StatelessWidget {
//   const HRDashboardLists({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: employeesLists.length,
//       itemBuilder: (context, index) {
//         final employees = employeesLists[index];
//         return Padding(
//           padding: const EdgeInsets.only(bottom: 2),
//           child: GestureDetector(
//             onTap: () => Get.toNamed(Routes.details),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(width: 1, color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxHeight: 90),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             employees['id']!,
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                               fontSize: 13,
//                             ),
//                           ),
//                           Text(
//                             employees['name']!,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           Text(
//                             'Project: ${employees['project']}',
//                             style: TextStyle(
//                                 color: Colors.grey.shade600, fontSize: 12.5),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             employees['branch']!,
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           RichText(
//                               text: TextSpan(
//                                   text: 'IN: ',
//                                   style: const TextStyle(
//                                     fontSize: 11.8,
//                                     color: Colors.black,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                   text: employees['check_in']!,
//                                   style: const TextStyle(
//                                     color: CustomColors.blueTextColor,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ])),
//                           RichText(
//                               text: TextSpan(
//                                   text: 'OUT: ',
//                                   style: const TextStyle(
//                                     fontSize: 11.8,
//                                     color: Colors.black,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                   text: employees['check_out']!,
//                                   style: const TextStyle(
//                                     color: CustomColors.blueTextColor,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ])),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
