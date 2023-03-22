import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/routes/app_routes.dart';

import '../../../core/constants/styles.dart';
import '../../../core/constants/widgets.dart';
import '../../../network/end_points.dart';
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
                  hintText: 'Search',
                  fillColor: CustomColors.whiteTextColor,
                  controller: Get.find<ChatController>(),
                ),
                kSizedBoxH8,
                Expanded(
                  child: Obx(() {
                    var chat = Get.find<ChatController>()
                        .chatGrouplist
                        .value
                        .chats
                        .reversed
                        .toList()
                        .where((element) => element.groupName
                            .toLowerCase()
                            .contains(Get.find<ChatController>()
                                .searchKeyword
                                .value
                                .toLowerCase()))
                        .toList();
                    return ListView.builder(
                      itemCount: chat.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.find<ChatController>().selectedItemIndex =
                                index;
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
                                      backgroundImage: NetworkImage(
                                          '$kImageUrl${chat[index].profilePic}'),
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
                                  width: 15,
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
                                            chat[index].groupName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(
                                                    Get.find<ChatController>()
                                                        .chatGrouplist
                                                        .value
                                                        .chats[index]
                                                        .createdAt
                                                        .toString())),
                                            style: const TextStyle(
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
