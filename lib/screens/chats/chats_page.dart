import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/core/constants/icons.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/chatMessages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessages> messages = [
    ChatMessages(
        chatMessage: "Hi, Jimmy! any update today? please come today as well",
        chatType: ChatType.hod),
    ChatMessages(
        chatMessage: "All good! we have some update  please come today as well",
        chatType: ChatType.employee),
  ];
  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: CustomColors.circleAvatarBackgroundColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Darlene Robertson",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.blueTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: CustomColors.chatPageBackgroundColor,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Align(
                        alignment: (message.chatType == ChatType.employee)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          width: w * 0.6,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: (message.chatType == ChatType.employee)
                                ? CustomColors.blueTextColor
                                : CustomColors.whiteTextColor,
                            borderRadius:
                                (message.chatType == ChatType.employee)
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
                            message.chatMessage,
                            style: TextStyle(
                                color: (message.chatType == ChatType.employee)
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
            Container(
              color: CustomColors.whiteCardColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type here...",
                          hintStyle: TextStyle(
                            color: CustomColors.blueTextColor,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      IconPath.sendSvg,
                      height: 20,
                      width: 20,
                    ),
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
