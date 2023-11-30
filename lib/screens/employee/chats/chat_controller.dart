import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paytym/core/dialog_helper.dart';
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
  int selectedItemIndex = -1;
  final scrollController = ScrollController();

  fetchChatGroupList() async {
    Get.find<BaseClient>().onError = () {
      fetchChatGroupList();
    };
    var requestModel = {};
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
  }

  fetchChat({bool isFromNotification = false}) async {
    print("fetchChat called");
    if (!isFromNotification) {
      showLoading();
      Get.find<BaseClient>().onError = fetchChat;
    }
    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.getChat,
            jsonEncode({
              'group_chat_id': chatGrouplist
                  .value.chats![selectedItemIndex].groupChatId
                  .toString()
            }),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    print(responseString);

    if (responseString != null) {
      chatResponseModel.value = chatResponseModelFromJson(responseString);
      chatResponseModel.refresh();
      scrollDown();
      hideLoading();
      Get.find<BaseClient>().onError = null;
    }
  }

  scrollDown() {
    Future.delayed(const Duration(milliseconds: 80), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
    });
  }

  sendChat() async {
    print("Send chat called");
    if (chatTextController.text.isNotEmpty) {

   
      final employee =
          Get.find<LoginController>().loginResponseModel!.employee!;
      chatResponseModel.value.chats ??= [];
      chatResponseModel.value.chats?.add(
        Chat(
            userId: employee.id,
            employerId: employee.employerId,
            message: chatTextController.text,
            createdAt: DateTime.now(),
            employee: Employee(
              firstName: employee.firstName,
              lastName: employee.lastName,
              image: employee.image,
            )),
      );
      chatResponseModel.refresh();
      scrollDown();
      String message = chatTextController.text;
      chatTextController.clear();
print("send chat success message:$message");
      var responseString = await Get.find<BaseClient>()
          .post(
              ApiEndPoints.sendChat,
              chatRequestModelToJson(ChatRequestModel(
                  message: message,
                  employerId: Get.find<LoginController>()
                      .loginResponseModel!
                      .employee!
                      .employerId
                      .toString(),
                  groupChatId: chatGrouplist
                      .value.chats![selectedItemIndex].groupChatId
                      .toString())),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);

      if (responseString == null) {
         print("send chat response:$responseString");
        chatResponseModel.value.chats!.removeLast();
        chatResponseModel.refresh();
        DialogHelper.showToast(desc: 'Something went wrong');
        chatTextController.text = message;
      }else{
        print("send chat response:$responseString");
        print(responseString.toString());

        fetchChat(isFromNotification:true );
      }
    }
  }
}
