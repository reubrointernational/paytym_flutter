import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/widgets.dart';
import 'package:paytym/routes/app_routes.dart';
import 'package:paytym/screens/admin/chat/chat_controller.dart';
import 'package:paytym/screens/admin/widgets/custom_admin_scaffold.dart';
import '../../../core/constants/strings.dart';
import '../../../core/constants/styles.dart';
import '../../employee/reports/widgets/year_dropdown.dart';

class SelectChatUsersPage extends StatelessWidget {
  const SelectChatUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAdminScaffold(
      title: 'Select Members',
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.createGroupPage),
        child: const Icon(Icons.arrow_forward),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            kSizedBoxH15,
            SizedBox(
              height: 40,
              child: Obx(
                () => ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(25)),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        margin: const EdgeInsets.only(right: 10),
                        child: const Text(
                          'All',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      ...List.generate(
                        2,
                        (index) => Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlue),
                              borderRadius: BorderRadius.circular(25)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.only(right: 10),
                          child: CustomDropdownYearButton(
                            lists: index == 0 ? departments : branches,
                            value: Get.find<ChatControllerAdmin>()
                                .selectedDropdownDepartments
                                .value,
                            onChanged: (value) {
                              Get.find<ChatControllerAdmin>()
                                  .selectedDropdownDepartments
                                  .value = value;
                            },
                            hint: selectMembersTabs[index],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Obx(() {
                var chatList = Get.find<ChatControllerAdmin>()
                    .chatGroupList
                    .where((element) => element.isSelected)
                    .toList();

                return SizedBox(
                    height: chatList.isEmpty ? 0 : 60,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage(chatList[index].image),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: InkWell(
                                    onTap: () {
                                      chatList[index].isSelected = false;
                                      Get.find<ChatControllerAdmin>()
                                          .chatGroupList
                                          .refresh();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ));
              }),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount:
                      Get.find<ChatControllerAdmin>().chatGroupList.length,
                  itemBuilder: (context, index) {
                    var chatList =
                        Get.find<ChatControllerAdmin>().chatGroupList;
                    return Obx(() => InkWell(
                          onTap: () => Get.find<ChatControllerAdmin>()
                              .updateChatSelection(index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.2, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                chatList[index].name,
                                style: kTextStyleS18W600CBlack,
                              ),
                              subtitle: Text(chatList[index].id),
                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage:
                                        NetworkImage(chatList[index].image),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    right: 0,
                                    child: Visibility(
                                      visible: chatList[index].isSelected,
                                      child: const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.green,
                                        child: Icon(
                                          Icons.done,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                chatList[index].branch,
                                style: kTextStyleS13W500Cgrey,
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
