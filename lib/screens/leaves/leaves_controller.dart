import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/leaves/leaves_request_model.dart';
import 'package:paytym/models/leaves/leaves_response.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';

import '../../models/message_only_response_model.dart';
import '../../network/base_client.dart';
import '../../network/end_points.dart';

class LeavesController extends GetxController with BaseController {
  final leaveResponseModel = LeaveResponseModel().obs;
  @override
  void onReady() {
    super.onReady();
    fetchLeaveData();
  }

  fetchLeaveData() async {
    showLoading();

    var responseString = await Get.find<BaseClient>()
        .get(ApiEndPoints.leave, Get.find<LoginController>().getHeader())
        .catchError(handleError);

    if (responseString == null) {
      return;
    } else {
      hideLoading();
      leaveResponseModel.value = leaveResponseModelFromJson(responseString);
    }
  }

  Future<MessageOnlyResponseModel?> applyForLeave(
      LeaveRequestModel leaveRequestModel) async {
    showLoading();

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.leave, leaveRequestModelToJson(leaveRequestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);

    if (responseString == null) {
      return null;
    } else {
      hideLoading();
      return messageOnlyResponseModelFromJson(responseString);
    }
  }

  String formatDate(String? date) {
    if (date == null) {
      return '';
    }
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('EEE, dd MMM').format(dateTime);
  }

  String getMonthFromDate(String? date) {
    if (date == null) {
      return '';
    }
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM yyyy').format(dateTime);
  }
}
