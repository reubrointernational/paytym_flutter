import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytym/models/chat/chat_group_list_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:http/http.dart' as http;

import '../../../core/dialog_helper.dart';
import '../../../models/chat/chat_create_request.dart';
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

  final chatGrouplist = ChatListGroupModel(message: '', chats: []).obs;
  int selectedItemIndex = 0;
  final selectedItemList = [].obs;

  final searchKeyword = ''.obs;

  final members = [].obs;
  final picker = ''.obs;

  ImagePicker imagePicker = ImagePicker();
  TextEditingController groupNameController = TextEditingController();

  /*fetchChatGroupList() async {
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
  }*/

  Future<void> uploadProfileImageFromCamera() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      DialogHelper.showToast(desc: 'No image selected');
    } else {
      picker.value = image.path;
    }
    Get.back();
  }

  Future<void> uploadProfileImageFromGallery() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      DialogHelper.showToast(desc: 'No image selected');
    } else {
      picker.value = image.path;
    }
    Get.back();
  }

  createChatGroup() async {
    if (members.isEmpty) {
      DialogHelper.showToast(desc: 'Group members should not be empty', backgroundColor: Colors.red);
    } else if (groupNameController.text.isEmpty) {
      DialogHelper.showToast(desc: 'Please provide a Group name', backgroundColor: Colors.red);
    } else if (picker.value.isEmpty) {
      DialogHelper.showToast(desc: 'Please upload a image', backgroundColor: Colors.red);
    } else {
      showLoading();
      var request = http.MultipartRequest(
          "POST", Uri.parse(ApiEndPoints.createChatGroup));
      ChatCreateRequestModel chatCreateRequestModel = ChatCreateRequestModel(
          employerId: Get.find<LoginController>()
                  .loginResponseModel
                  ?.employee
                  ?.employer_id
                  .toString() ??
              '',
          groupName: groupNameController.text,
          members: members.toString());
      request.fields.addAll(chatCreateRequestModel.toJson());
      request.headers.addAll(Get.find<LoginController>().getHeader()!);
      var multipartFile =
          await http.MultipartFile.fromPath('profile_pic', picker.value);
      request.files.add(multipartFile);
      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);
      print(response.body);
      hideLoading();
      DialogHelper.showToast(desc: 'New Chat Group Created');
    }
  }
}
