import 'dart:convert';

import 'package:get/get.dart';
import 'package:paytym/models/chat/chat_group_list_model.dart';
import 'package:paytym/network/base_controller.dart';

import '../../../core/constants/enums.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';
import '../dashboard/dashboard_controller.dart';
import '../../../models/employee_list_model.dart';

List<Model> dummy_data = [
  Model('Group1', '0004', 'branch1',
      'https://dummyimage.com//300/09f/fff.png&text=Group1'),
  Model('Group2', '0005', 'branch2',
      'https://dummyimage.com//300/09f/fff.png&text=Group2'),
  Model('Group3', '0006', 'branch3',
      'https://dummyimage.com//300/09f/fff.png&text=Group3'),
];

class Model {
  String name;
  String id;
  String branch;
  String image;
  bool isSelected = false;
  Model(this.name, this.id, this.branch, this.image);
}

class ChatControllerAdmin extends GetxController with BaseController {
  final selectedDropdownDepartments = Rxn<String>();
  final selectedDropdownBranches = Rxn<String>();

  final chatGrouplist = ChatListGroupModel(message: '', chats: []).obs;
  int selectedItemIndex = 0;
  final selectedItemList = [].obs;

  final searchKeyword = ''.obs;
  final selectMemberTab = SelectChatMemberTab.all.obs;

  @override
  void onReady() {
    super.onReady();
    fetchChatGroupList();
  }

  fetchChatGroupList() async {
    Get.find<BaseClient>().onError = fetchChatGroupList;
    var requestModel = {'status': '1'};
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.chatGroupList, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      chatGrouplist.value = chatListGroupModelFromJson(responseString);
      Get.find<BaseClient>().onError = null;
    }
  }

  resetTabs(SelectChatMemberTab tab) {
    selectMemberTab.value = tab;
    if (tab == SelectChatMemberTab.all) {
      selectedDropdownDepartments.value = null;
      selectedDropdownBranches.value = null;
    }
  }

  getEmployees() {
    switch (selectMemberTab.value) {
      case SelectChatMemberTab.branch:
        return selectedDropdownDepartments.value == null
            ? Get.find<DashboardControllerAdmin>()
                .branchwiseEmployeeMap[selectedDropdownBranches.value]
            : Get.find<DashboardControllerAdmin>()
                .deptwiseEmployeeMap[selectedDropdownDepartments.value]
                ?.where(
                (element) => element.branch?.name == selectedDropdownBranches.value);
      case SelectChatMemberTab.department:
        return Get.find<DashboardControllerAdmin>()
            .deptwiseEmployeeMap[selectedDropdownDepartments.value];
      default:
        return Get.find<DashboardControllerAdmin>()
            .employeeList
            .value
            .employeeList;
    }
  }
}
