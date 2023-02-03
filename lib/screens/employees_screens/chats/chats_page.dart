import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytym/core/constants/styles.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/screens/employees_screens/chats/chat_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../widgets/custom_cached_network_image.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Row(
                children: [
                  Obx(() => CustomCachedNetworkImage(
                        imageUrl:
                            chatController.chatResponseModel.value.hodImage ??
                                '',
                        radius: 24,
                      )),
                  kSizedBoxW10,
                  Obx(() => Text(
                        chatController.chatResponseModel.value.hod ?? '',
                        style: kTextStyleS13W600.copyWith(
                            color: CustomColors.blueTextColor),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: CustomColors.chatPageBackgroundColor,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Obx(
                  () => ListView.builder(
                    controller: chatController.scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                        chatController.chatResponseModel.value.chats?.length ??
                            0,
                    itemBuilder: (context, index) {
                      final chat =
                          chatController.chatResponseModel.value.chats![index];
                      final userId = Get.find<LoginController>()
                          .loginResponseModel!
                          .employee!
                          .id;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Align(
                          alignment: (userId == chat.userId)
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: w * 0.6,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: (userId == chat.userId)
                                  ? CustomColors.blueTextColor
                                  : CustomColors.whiteTextColor,
                              borderRadius: (userId == chat.userId)
                                  ? const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    )
                                  : const BorderRadius.only(
                                      bottomRight: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                            ),
                            child: Text(
                              chat.message!,
                              style: TextStyle(
                                  color: (userId == chat.userId)
                                      ? CustomColors.whiteTextColor
                                      : CustomColors.greyTextColor,
                                  height: 1.2),
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
              color: CustomColors.whiteCardColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatController.chatTextController,
                        decoration: const InputDecoration(
                          hintText: kTypeHereString,
                          hintStyle: TextStyle(
                            color: CustomColors.blueTextColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () => chatController.sendChat(
                            chatController.chatTextController.text,
                            chatController.chatResponseModel.value.chatHistory
                                ?.first.employerId),
                        icon: SvgPicture.asset(
                          IconPath.sendSvg,
                          color: CustomColors.blueTextColor,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
