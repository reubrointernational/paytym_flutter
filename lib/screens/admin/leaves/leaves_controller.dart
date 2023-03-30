import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/core/colors/colors.dart';
import 'package:paytym/core/constants/enums.dart';
import 'package:paytym/models/leaves/leaves_accept_decline_request_model.dart';
import 'package:paytym/models/leaves/leaves_request_model.dart';
import 'package:paytym/models/leaves/leaves_status_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/login/login_controller.dart';
import '../../../core/constants/strings.dart';
import '../../../core/dialog_helper.dart';
import '../../../models/leaves/leaves_admin_response_model.dart';
import '../../../models/message_only_response_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../widgets/reason_bottomsheet.dart';
import '../../../models/leaves/leave_type_model.dart' as leave_type;
import 'leaves_filter_controller.dart';

class LeavesControllerAdmin extends GetxController
    with BaseController, LeavesFilterController {
  final leaveAdminResponseModel =
      LeavesListAdminModel(message: '', leaveRequest: []).obs;

  final searchKeyword = ''.obs;

  final formKey = GlobalKey<FormState>();
  LeaveRequestModel leaveRequestModel = LeaveRequestModel();
  final selectedItem = 'annual'.obs;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final selectedDepartment = departments.first.obs;
  final selectedBranch = branches.first.obs;
  LeaveRequest selectedLeaveRequest = LeaveRequest();
  final leaveTypesModel = leave_type.LeaveTypesModel().obs;

  //for bottomsheet
  final requestAdvanceFormKey = GlobalKey<FormState>();
  String acceptRejectReason = '';

  isToday(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateTimeInYMD = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (dateTimeInYMD == today) return true;
    return false;
  }

  isYesterday(DateTime dateTime) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateTimeInYMD = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateTimeInYMD == yesterday) {
      return true;
    }
    return false;
  }

  //for bottomsheet
  showBottomSheetForReason(ReasonButton reasonButton) {
    DialogHelper.showBottomSheet(ReasonBottomSheetAdmin(
      reasonButton: reasonButton,
    ));
  }

  getLeaveType(int? typeId) {
    return leaveTypesModel.value.leaveTypes
            ?.firstWhere((element) => element.id == typeId)
            .leaveType ??
        '';
  }

  //for bottomsheet validation
  String? notEmptyValidator(String value) {
    return (value.isEmpty) ? 'Value cannot be empty' : null;
  }

  //send reason (incomplete)
  Future<void> sendReason() async {
    // if (requestAdvanceFormKey.currentState!.validate()) {
    //   requestAdvanceFormKey.currentState!.save();
    //   if (quitCompanyReason.isNotEmpty) {
    //     showLoading();
    //     String json = jsonEncode({'requests': quitCompanyReason});
    //     var responseString = await Get.find<BaseClient>()
    //         .post(ApiEndPoints.quitCompany, json,
    //             Get.find<LoginController>().getHeader())
    //         .catchError(handleError);
    //     if (responseString == null) {
    //       return;
    //     } else {
    //       hideLoading();
    //       DialogHelper.showToast(desc: 'Request submitted successfully');
    //       Get.back();
    //     }
    //   }
    // }
  }

  getLeaveTypes() async {
    if (leaveTypesModel.value.leaveTypes?.isEmpty ?? true) {
      Get.find<BaseClient>().onError = getLeaveTypes;
      Map<String, dynamic> requestModel = {
        'employer_id':
            '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
      };
      var responseString = await Get.find<BaseClient>()
          .post(ApiEndPoints.leaveTypes, jsonEncode(requestModel),
              Get.find<LoginController>().getHeader())
          .catchError(handleError);

      if (responseString == null) {
        return;
      } else {
        leaveTypesModel.value =
            leave_type.leaveTypesModelFromJson(responseString);

        leaveTypesModel.refresh();
        Get.find<BaseClient>().onError = null;
      }
    }
  }

  fetchLeaveData([int status = 1]) async {
    //status 1 means all leaves,
    showLoading();
    Get.find<BaseClient>().onError = fetchLeaveData;
    var requestModel = {
      'status': status,
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.leaveRequestAdmin, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      leaveAdminResponseModel.value =
          leavesListAdminModelFromJson(responseString);

      Get.find<BaseClient>().onError = null;
    }
  }

  approveOrDeclineLeave(ReasonButton reasonButton) async {
    showLoading();
    final model = LeaveAcceptDeclineRequestModel(
        reason: acceptRejectReason,
        employeeId: selectedLeaveRequest.userId.toString(),
        approvalStatus: reasonButton == ReasonButton.leaveApprove ? '1' : '0',
        leaveRequestId: selectedLeaveRequest.id.toString());

    var responseString = await Get.find<BaseClient>()
        .post(
            ApiEndPoints.leaveAcceptReject,
            leaveAcceptDeclineRequestModelToJson(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      DialogHelper.showToast(
          desc: messageOnlyResponseModelFromJson(responseString).message ?? '');
      Get.back();
      leaveAdminResponseModel.value.leaveRequest?.remove(selectedLeaveRequest);
      leaveAdminResponseModel.refresh();
    }
    selectedLeaveRequest = LeaveRequest();
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

  Future<void> selectDateTime(BuildContext context, bool isStartDate) async {
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );
    isStartDate ? startDate = dateTime! : endDate = dateTime!;

    isStartDate
        ? startDateController.text = getDateString(startDate)
        : endDateController.text = getDateString(endDate);
  }

  String getDateString(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    return DateFormat('dd-MM-yyyy').format(dateTime).toString();
  }

  String getDateReverseString(String? date) {
    if (date == null) {
      return '';
    }
    var inputFormat = DateFormat('dd-MM-yyyy');
    var inputDate = inputFormat.parse(date);

    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }

  String? titleValidator(String value) {
    return GetUtils.isLengthLessThan(value, 5)
        ? "Title should be minimum 5 characters"
        : null;
  }

  String? dateValidator(String value) {
    final regExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\-(0[1-9]|1[012])\-\d{4}$');
    return regExp.hasMatch(value) && GetUtils.isLengthEqualTo(value, 10)
        ? null
        : "Enter a valid date";
  }

  LeaveStatusModel getLeaveStatusModel(String? status) {
    switch (status) {
      case '1':
        //1 => status - approved
        return LeaveStatusModel(
            'Approved', CustomColors.greenColor, CustomColors.lightGreenColor);
      case '2':
        //2 => status - declined
        return LeaveStatusModel(
            'Declined', CustomColors.redColor, CustomColors.lightRedColor);
      case '0':
      default:
        //0 => status - awaiting
        return LeaveStatusModel('Awaiting', CustomColors.orangeLabelColor,
            CustomColors.lightOrangeColor);
    }
  }
}
