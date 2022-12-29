// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:paytym/core/colors/colors.dart';

// import '../../../core/constants/strings.dart';
// import 'settings_titles.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColors.backgroundColor,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 20.0, top: 20.0),
//                 child: Text(
//                   "Settings",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 12,
//               child: Container(
//                 //color: Colors.blue,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 7,
//                       child: Column(children: [
//                         const SettingsTitles(text: 'Manage'),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: settingsManage.length,
//                             itemBuilder: (context, index) {
//                               final manage = settingsManage[index];
//                               return ListTile(
//                                 //contentPadding: EdgeInsets.zero,
//                                 dense: true,
//                                 leading: Image.asset(
//                                   manage['icon'],
//                                 ),
//                                 title: Text(
//                                   manage['title'],
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 trailing: SvgPicture.asset(
//                                     'assets/svg/arrow_forward.svg'),
//                               );
//                             },
//                           ),
//                         ),
//                       ]),
//                     ),
//                     Expanded(
//                       flex: 5,
//                       child: Column(children: [
//                         const SettingsTitles(text:'Uploads'),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: settingsUploads.length,
//                             itemBuilder: (context, index) {
//                               final manage = settingsUploads[index];
//                               return ListTile(
//                                 //contentPadding: EdgeInsets.zero,
//                                 dense: true,
//                                 leading: Image.asset(
//                                   manage['icon'],
//                                 ),
//                                 title: Text(
//                                   manage['title'],
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 trailing: SvgPicture.asset(
//                                     'assets/svg/arrow_forward.svg'),
//                               );
//                             },
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
