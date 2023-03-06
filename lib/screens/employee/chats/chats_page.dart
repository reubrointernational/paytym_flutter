import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytym/models/chat/chat_response_model.dart';
import 'package:paytym/screens/employee/chats/chat_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(controller
            .chatGrouplist.value.chats[controller.selectedItemIndex].groupName),
        backgroundColor: CustomColors.backgroundColor,
      ),
      backgroundColor: CustomColors.backgroundColor,
      body: SafeArea(
        child: Animate(
          effects: const [
            FadeEffect(
                delay: Duration(milliseconds: 100), curve: Curves.easeInOut),
            ScaleEffect(curve: Curves.easeInOut),
          ],
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: CustomColors.chatPageBackgroundColor,
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Obx(
                    () => ListView.builder(
                      controller: Get.find<ChatController>().scrollController,
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
                          controller:
                              Get.find<ChatController>().chatTextController,
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
                          onPressed: () => Get.find<ChatController>().sendChat(
                              Get.find<ChatController>()
                                  .chatTextController
                                  .text,
                              Get.find<ChatController>()
                                  .chatResponseModel
                                  .value
                                  .chatHistory
                                  ?.first
                                  .employerId),
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
      ),
    );
  }
}
