// import 'package:flutter/material.dart';
// import 'package:paytym/core/colors/colors.dart';
// import 'package:paytym/core/constants/icons.dart';

// import '../widgets/floating_action_button.dart';
// import 'dashboard_lists.dart';


// class HRDashboardPage extends StatefulWidget {
//   const HRDashboardPage({super.key});

//   @override
//   State<HRDashboardPage> createState() => _HRDashboardPageState();
// }

// class _HRDashboardPageState extends State<HRDashboardPage> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: CustomColors.backgroundColor,
//       floatingActionButton: const CustomFloatingActionButton(),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   //color: Colors.yellow,
//                   child: Image.asset(
//                     IconPath.logoImgPng,
//                     height: size.height * 0.05,
//                     width: size.width * 0.26,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundColor: Colors.grey.shade300,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Expanded(
//               child: HRDashboardLists(),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
