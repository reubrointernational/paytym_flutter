import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/screens/admin/chat/chat_controller.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/icons.dart';
import '../../../core/constants/styles.dart';

class ChatPageAdmin extends StatelessWidget {
  const ChatPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Group Name',
          style: kTextStyleS18W600white,
        ),
        elevation: 0,
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: CustomColors.lightBlueColor,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                color: CustomColors.whiteCardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: w * 0.6,
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                            color: CustomColors.lightBlueColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            )),
                        child: const Text(
                          "Hai, john",
                          style: TextStyle(
                              color: CustomColors.whiteTextColor, height: 1.2),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Text Here...",
                        hintStyle: TextStyle(
                          color: CustomColors.lightBlueColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
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
    );
  }
}
