import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paytym/models/chat/chat_request_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../models/chat/chat_group_list_model.dart' as chat_model;
import '../../../models/chat/chat_response_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';

class ChatController extends GetxController with BaseController {
  final chatResponseModel = ChatResponseModel().obs;
  final TextEditingController chatTextController = TextEditingController();
  final searchKeyword = ''.obs;
  final chatGrouplist =
      chat_model.ChatListGroupModel(message: '', chats: []).obs;
  int selectedItemIndex = 0;


  fetchChatGroupList(int isEmployee) async {
    Get.find<BaseClient>().onError = () {
      fetchChatGroupList(isEmployee);
    };
    //0 for employee, 1 for admin
    var requestModel = {'status': isEmployee};
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.chatGroupList, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      chatGrouplist.value =
          chat_model.chatListGroupModelFromJson(responseString);
      Get.find<BaseClient>().onError = null;
    }
    fetchChat();
  }

  fetchChat() async {
    showLoading();

    Get.find<BaseClient>().onError = fetchChat;
    var responseString = await Get.find<BaseClient>()
        .get(ApiEndPoints.getChat, Get.find<LoginController>().getHeader())
        .catchError(handleError);
    print(responseString);

    if (responseString != null) {
      chatResponseModel.value = chatResponseModelFromJson(responseString);
      chatResponseModel.refresh();
      //_jumpDown();
      hideLoading();
      Get.find<BaseClient>().onError = null;
    }
  }

  sendChat() async {
    // if (chatTextController.text.isNotEmpty) {
    //   chatResponseModel.value.chats!.add(
    //     Chat(
    //         userId:
    //             Get.find<LoginController>().loginResponseModel!.employee!.id,
    //         employerId: employerId,
    //         message: message),
    //   );
    //   chatResponseModel.refresh();

    //   String text = chatTextController.text;
    //   chatTextController.clear();
    //   //_scrollDown();
    //   var responseString = await Get.find<BaseClient>()
    //       .post(
    //           ApiEndPoints.sendChat,
    //           chatRequestModelToJson(
    //               ChatRequestModel(message: message, employerId: employerId)),
    //           Get.find<LoginController>().getHeader())
    //       .catchError(handleError);

    //   if (responseString == null) {
    //     chatResponseModel.value.chats!.removeLast();
    //     chatResponseModel.refresh();
    //     chatTextController.text = text;
    //   }
    // }
  }

  /* void _scrollDown() async {
    await Future.delayed(const Duration(milliseconds: 100));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _jumpDown() async {
    await Future.delayed(const Duration(milliseconds: 100));
    scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
  }*/
}
