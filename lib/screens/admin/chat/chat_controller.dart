import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytym/models/chat/chat_group_list_model.dart';
import 'package:paytym/network/base_controller.dart';

import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';

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
  final chatGroupList = dummy_data.obs;
  final chatGrouplist = ChatListGroupModel(message: '', chats: []).obs;
  int selectedItemIndex = 0;

  final searchKeyword = ''.obs;

  updateChatSelection(index) {
    chatGroupList[index].isSelected = !chatGroupList[index].isSelected;
    chatGroupList.refresh();
  }

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
}
