import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/strings.dart';
import 'package:paytym/screens/admin/chat/chat_controller.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants/widgets.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var memberList = Get.find<ChatControllerAdmin>()
        .chatGroupList
        .where((element) => element.isSelected).toList();
    return CustomAdminScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CustomColors.lightBlueColor,
        child: const Icon(
          Icons.done,
          color: CustomColors.whiteIconColor,
        ),
      ),
      title: 'Create New Group',
      widget: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: memberList.isEmpty ? 0 : 60,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(memberList[index].image),
                    ),
                  );
                },
              ),
            ),
          ),
          kSizedBoxH10,
          RichText(
              text: const TextSpan(
                  text: 'Group name ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ])),
          kSizedBoxH10,
          TextFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                      width: 1, color: CustomColors.lightBlueColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                      width: 1, color: CustomColors.lightBlueColor),
                )),
          ),
          kSizedBoxH20,
          const Text(
            'Attachments',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          kSizedBoxH10,
          GestureDetector(
            // onTap: () =>
            // createChatController.uploadProfileImage(),
            child: DottedBorder(
              strokeWidth: 1.5,
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              color: CustomColors.lightBlueColor,
              dashPattern: const [10, 2],
              child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: SizedBox(
                      width: w * 0.5,
                      child: const Text(
                        'Upload a PNG, JPG or GIF Image of max 10MB',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: CustomColors.greyTextColor,
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          kSizedBoxH20,
        ]),
      ),
    );
  }
}
