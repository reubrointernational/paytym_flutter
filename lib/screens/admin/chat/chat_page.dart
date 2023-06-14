import 'dart:async';

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
import '../../../models/chat/chat_response_model.dart';
import '../dashboard/dashboard_controller.dart';
import '../../employee/chats/chat_controller.dart';
import '../../login/login_controller.dart';
import '../../widgets/chat_clippath_cut.dart';

class ChatPageAdmin extends StatefulWidget {
  const ChatPageAdmin({super.key});

  @override
  State<ChatPageAdmin> createState() => _ChatPageAdminState();
}

class _ChatPageAdminState extends State<ChatPageAdmin> {
  Timer? timer;
  
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Get.find<ChatController>().fetchChat(isFromNotification: true);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ChatControllerAdmin());

    Get.find<DashboardControllerAdmin>().selectedItemList.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ChatController>().chatResponseModel.value = ChatResponseModel();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.find<ChatController>()
                  .chatGrouplist
                  .value
                  .chats?[Get.find<ChatController>().selectedItemIndex]
                  .group
                  ?.groupName ??
              'Chat',
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
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: Get.find<ChatController>().scrollController,
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '~${chat.employee?.firstName}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          chat.message!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color:
                                                  CustomColors.whiteTextColor,
                                              height: 1.2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      DateFormat('hh:mm a').format(
                                          DateTime.parse(
                                                  chat.createdAt.toString())
                                              .toLocal()),
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
                        onPressed: () => Get.find<ChatController>().sendChat(),
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
