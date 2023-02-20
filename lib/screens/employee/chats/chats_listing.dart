import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/routes/app_routes.dart';

import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../../admin/dashboard/widgets/custom_text_form_field.dart';
import '../calendar/widgets/custom_svg.dart';
import 'chat_controller.dart';
import 'chats_page.dart';

class ChatListingPage extends StatelessWidget {
  const ChatListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomSVG(
            IconPath.menuSvg,
          ),
        ),
        elevation: 0,
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Container(
              color: const Color.fromRGBO(231, 238, 254, 1),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(children: [
                CustomSearchTextField(
                  iconImg: IconPath.searchIconPng,
                  
                  hintText: 'Search', controller: Get.find<ChatController>(),
                ),
                kSizedBoxH8,
                Expanded(
                  child: Obx(() {
                    var dummy = Get.find<ChatController>()
                        .dummy_data
                        .where((element) => element.toLowerCase().contains(
                            Get.find<ChatController>().searchKeyword.value.toLowerCase()))
                        .toList();
                    return ListView.builder(
                      itemCount: dummy.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.chat);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color: CustomColors.whiteCardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.pink.shade200,
                                      child: Center(
                                          child: Text(
                                        dummy[index].substring(0, 1),
                                        style: const TextStyle(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            dummy[index],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Text(
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
                          ),
                        );
                      },
                    );
                  }),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}