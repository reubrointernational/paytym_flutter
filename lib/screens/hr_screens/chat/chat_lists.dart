import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/screens/hr_screens/dashboard/widgets/custom_text_form_field.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/widgets.dart';
import '../dashboard/widgets/app_bar.dart';

class HRChatLists extends StatelessWidget {
  const HRChatLists({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.lightBlueColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.whiteTextColor,
                  ),
                ),
                SvgPicture.asset(
                  IconPath.editIconSvg,
                  height: 20,
                  width: 20,
                  color: CustomColors.whiteTextColor,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: CustomColors.whiteCardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomSearchTextField(
                    iconImg: IconPath.searchIconPng,
                    hintText: 'Search for chats & messages',
                  ),
                ),
                kSizedBoxH8,
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.pink.shade200,
                                  child: const Center(
                                      child: Text(
                                    'J',
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                                ),
                                const Positioned(
                                  right: 2,
                                  bottom: 0,
                                  child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 226, 117)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'John Smith',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '1/2/2022',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: CustomColors.greyIconColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kSizedBoxH2,
                                  const Text(
                                    'Hai, John! How are you doing?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: CustomColors.greyIconColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
