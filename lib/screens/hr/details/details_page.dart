// import 'package:flutter/material.dart';
// import 'package:paytym/core/colors/colors.dart';
// import 'package:paytym/core/constants/widgets.dart';

// import '../../../core/constants/strings.dart';
// import 'custom_outlined_buttons.dart';

// class DetailsPage extends StatefulWidget {
//   const DetailsPage({super.key});

//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
  

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: CustomColors.backgroundColor,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.grey.shade400,
//                     radius: 25,
//                   ),
//                   kSizedBoxW15,
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Natalie Smith',
//                         style: TextStyle(
//                           color: CustomColors.blueTextColor,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(
//                         'ID No.00457854',
//                         style:
//                             TextStyle(color: CustomColors.lightGreyTextColor),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(maxHeight: 70),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Email   :  natalie@info.com',
//                                 style: TextStyle(
//                                     color: Colors.grey.shade800, fontSize: 15),
//                               ),
//                               Text(
//                                 'Phone  :  +918568493834',
//                                 style: TextStyle(
//                                     color: Colors.grey.shade800, fontSize: 15),
//                               ),
//                               Text(
//                                 'Date     :  DD/MM/YEAR',
//                                 style: TextStyle(
//                                     color: Colors.grey.shade800, fontSize: 15),
//                               ),
//                             ]),
//                         const Align(
//                           alignment: Alignment.topRight,
//                           child: Icon(
//                             Icons.edit_outlined,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: size.height * 0.5,
//                 //color: Colors.yellow,
//                 child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 10,
//                             childAspectRatio: 2 / 1.8),
//                     itemCount: choices.length,
//                     itemBuilder: (context, index) {
//                       final choice = choices[index];
//                       return Container(
//                         padding: const EdgeInsets.all(18),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: choice['color']),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Image.asset(
//                                 choice['icon'],
//                                 height: size.height * 0.075,
//                                 width: size.width * 0.12,
//                                 fit: BoxFit.cover,
//                               ),
//                               Text(
//                                 choice['text'].toUpperCase(),
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: CustomColors.whiteTextColor,
//                                 ),
//                               ),
//                             ]),
//                       );
//                     }),
//               ),
//               Container(
//                 width: size.width,
//                 height: size.height * 0.06,
//                 child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: CustomColors.blueCardColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         )),
//                     child: const Text(
//                       'Upload Document',
//                       style: TextStyle(
//                         color: CustomColors.whiteTextColor,
//                         fontSize: 16,
//                       ),
//                     )),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   CustomOutlinedButton(text: 'Suspend', color: Colors.green),
//                   CustomOutlinedButton(text: 'Terminate',color: Colors.pink),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
