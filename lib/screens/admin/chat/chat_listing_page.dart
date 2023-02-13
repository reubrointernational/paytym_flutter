import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/routes/app_routes.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/widgets.dart';
import '../dashboard/widgets/custom_text_form_field.dart';
import 'chat_controller.dart';

class ChatListingPageAdmin extends StatelessWidget {
  const ChatListingPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatControllerAdmin());
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
                InkWell(
                  onTap: () => Get.toNamed(Routes.selectChatUsersPage),
                  child: SvgPicture.asset(
                    IconPath.editIconSvg,
                    height: 20,
                    width: 20,
                    color: CustomColors.whiteTextColor,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: h,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: CustomColors.whiteCardColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomSearchTextField(
                    controller: Get.find<ChatControllerAdmin>(),
                    iconImg: IconPath.searchIconPng,
                    hintText: 'Search for chats & messages',
                  ),
                ),
                kSizedBoxH8,
                Expanded(
                  child: Obx(() {
                    var dummy = Get.find<ChatControllerAdmin>()
                        .dummyData
                        .where((element) => element.toLowerCase().contains(
                            Get.find<ChatControllerAdmin>()
                                .searchKeyword
                                .value
                                .toLowerCase()))
                        .toList();
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: dummy.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Get.toNamed(Routes.adminChat),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: BoxDecoration(
                              color:
                                  CustomColors.lightBlueColor.withOpacity(0.1),
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
