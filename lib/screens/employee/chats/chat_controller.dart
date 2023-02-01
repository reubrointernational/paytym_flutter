import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:paytym/models/chat/chat_request_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../../models/chat/chat_response_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';

class ChatController extends GetxController with BaseController {
  final chatResponseModel = ChatResponseModel().obs;
  final TextEditingController chatTextController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  @override
  void onReady() {
    super.onReady();
    fetchChat();
  }

  void fetchChat() async {
    showLoading();
    Get.find<BaseClient>().onError = fetchChat;
    var responseString = await Get.find<BaseClient>()
        .get(ApiEndPoints.getChat, Get.find<LoginController>().getHeader())
        .catchError(handleError);

    if (responseString != null) {
      chatResponseModel.value = chatResponseModelFromJson(responseString);
      chatResponseModel.refresh();
      _jumpDown();
      hideLoading();
      Get.find<BaseClient>().onError = null;
    }
  }

  sendChat(String? message, int? employerId) async {
    if (message != null &&
        message.isNotEmpty &&
        employerId != null &&
        Get.find<LoginController>().loginResponseModel?.employee?.id != null) {
      chatResponseModel.value.chats?.add(
        Chat(
            userId:
                Get.find<LoginController>().loginResponseModel!.employee!.id,
            employerId: employerId,
            message: message),
      );
      chatResponseModel.refresh();

      String text = chatTextController.text;
      chatTextController.clear();
      _scrollDown();
      var responseString = await Get.find<BaseClient>()
          .post(
              ApiEndPoints.sendChat,
              chatRequestModelToJson(
                  ChatRequestModel(message: message, employerId: employerId)),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);

      if (responseString == null) {
        chatResponseModel.value.chats?.removeLast();
        chatResponseModel.refresh();
        chatTextController.text = text;
      }
    }
  }

  void _scrollDown() async {
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
  }
}
