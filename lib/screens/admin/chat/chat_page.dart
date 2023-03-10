import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/screens/admin/chat/chat_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/styles.dart';
import '../dashboard/dashboard_controller.dart';
import '../../../core/constants/widgets.dart';
import '../../employee/chats/chat_controller.dart';
import '../../login/login_controller.dart';
import '../../widgets/chat_clippath_cut.dart';

class ChatPageAdmin extends StatelessWidget {
  const ChatPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatControllerAdmin>();
    Get.find<DashboardControllerAdmin>().isSelectMembersPageFromChat = true;
    Get.find<DashboardControllerAdmin>().selectedItemList.clear();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.find<ChatController>()
              .chatGrouplist
              .value
              .chats[Get.find<ChatController>().selectedItemIndex]
              .groupName,
          style: kTextStyleS18W600white,
        ),
        elevation: 0,
        backgroundColor: CustomColors.lightBlueColor,
      ),
      backgroundColor: CustomColors.lightBlueColor,
      body: SafeArea(
        child: Animate(
          effects: const [
            FadeEffect(
                delay: Duration(milliseconds: 100), curve: Curves.easeInOut),
            ScaleEffect(curve: Curves.easeInOut),
          ],
          child: Column(children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  color: CustomColors.whiteCardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: Get.find<ChatController>()
                          .chatResponseModel
                          .value
                          .chats
                          ?.length ??
                      0,
                  itemBuilder: (context, index) {
                    final chat = Get.find<ChatController>()
                        .chatResponseModel
                        .value
                        .chats![index];
                    final userId = Get.find<LoginController>()
                        .loginResponseModel!
                        .employee!
                        .id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: userId == chat.userId
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ClipPath(
                          clipper: userId == chat.userId
                              ? CustomSenderChatDesign()
                              : CustomReceiverChatDesign(),
                          child: Container(
                            width: w * 0.85,
                            padding: userId == chat.userId
                                ? const EdgeInsets.fromLTRB(15, 15, 20, 15)
                                : const EdgeInsets.fromLTRB(20, 15, 15, 15),
                            decoration: BoxDecoration(
                                color: userId == chat.userId
                                    ? Colors.deepPurple
                                    : Colors.teal,
                                borderRadius: userId == chat.userId
                                    ? const BorderRadius.only(
                                        //topRight: Radius.circular(15),
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))
                                    : const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        //topLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(15),
                                      )),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      userId != chat.userId
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                '876543234',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      Text(
                                        chat.message!,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: CustomColors.whiteTextColor,
                                            height: 1.2),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    DateFormat('hh:mm a').format(DateTime.parse(
                                        chat.createdAt.toString())),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: CustomColors.whiteCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: /* Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            Get.find<ChatController>().chatTextController,
                        decoration: const InputDecoration(
                          hintText: "Text Here...",
                          hintStyle: TextStyle(
                            color: CustomColors.lightBlueColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => Get.find<ChatController>().sendChat(
                            Get.find<ChatController>().chatTextController.text,
                            Get.find<ChatController>()
                                .chatResponseModel
                                .value
                                .chatHistory
                                ?.first
                                .employerId),
                        icon: SvgPicture.asset(
                          IconPath.sendSvg,
                          color: CustomColors.lightBlueColor,
                        )),
                  ],
                ),*/

                    Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            Get.find<ChatController>().chatTextController,
                        decoration: const InputDecoration(
                          hintText: kTypeHereString,
                          hintStyle: TextStyle(
                            color: CustomColors.lightBlueColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => Get.find<ChatController>().sendChat(
                            Get.find<ChatController>().chatTextController.text,
                            Get.find<ChatController>()
                                .chatResponseModel
                                .value
                                .chatHistory
                                ?.first
                                .employerId),
                        icon: SvgPicture.asset(
                          IconPath.sendSvg,
                          color: CustomColors.lightBlueColor,
                        )),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
