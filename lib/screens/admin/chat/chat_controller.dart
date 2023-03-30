import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytym/models/chat/chat_group_list_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:paytym/screens/admin/chat/chat_listing_page.dart';
import 'package:paytym/screens/employee/chats/chat_controller.dart';

import '../../../core/dialog_helper.dart';
import '../../../network/end_points.dart';
import '../../../routes/app_routes.dart';
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
  final chatGrouplist = ChatListGroupModel(message: '', chats: []).obs;
  int selectedItemIndex = 0;

  final searchKeyword = ''.obs;

  List<EmployeeList>? members = [];
  final picker = ''.obs;

  ImagePicker imagePicker = ImagePicker();
  TextEditingController groupNameController = TextEditingController();

  /*fetchChatGroupList() async {
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
    List<String>? userIdList = members?.map((e) => e.id.toString()).toList();
    if (userIdList?.isEmpty ?? true) {
      DialogHelper.showToast(
          desc: 'Group members should not be empty',
          backgroundColor: Colors.red);
    } else if (groupNameController.text.isEmpty) {
      DialogHelper.showToast(
          desc: 'Please provide a Group name', backgroundColor: Colors.red);
    } else if (picker.value.isEmpty) {
      DialogHelper.showToast(
          desc: 'Please upload a image', backgroundColor: Colors.red);
    } else {
      showLoading();
      var request = http.MultipartRequest(
          "POST", Uri.parse(ApiEndPoints.createChatGroup));

      request.fields['employer_id'] = Get.find<LoginController>()
              .loginResponseModel
              ?.employee
              ?.employerId
              .toString() ??
          '';
      request.fields['group_name'] = groupNameController.text;
      if (userIdList != null) {
        userIdList.forEach((element) {
          request.fields.addAll({"members[]": element.toString()});
        });
      }
      request.headers['Authorization'] =
          'Bearer ${Get.find<LoginController>().loginResponseModel?.token}';
      var multipartFile =
          await http.MultipartFile.fromPath('profile_pic', picker.value);
      request.files.add(multipartFile);
      var streamResponse = await request.send();
      var response = await http.Response.fromStream(streamResponse);

      hideLoading();
      if (response.statusCode == 200) {
        DialogHelper.showToast(desc: 'New Chat Group Created');
        Get.back();
        Get.back();
        Get.find<ChatController>().fetchChatGroupList();
      } else {
        DialogHelper.showToast(desc: response.body);
      }
    }
  }
}
