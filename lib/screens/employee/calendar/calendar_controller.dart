import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/calendar/events_respnse_model.dart';
import 'package:paytym/models/calendar/meeting_response_model.dart';
import 'package:paytym/network/base_controller.dart';

import '../../../core/constants/enums.dart';
import '../../../models/calendar/holiday_admin_response_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';

class CalendarController extends GetxController with BaseController {
  final selectedCalendarTab = CalendarTabs.meeting.obs;
  final meetingResponseModel = MeetingResponseModel().obs;
  final eventsResponseModel = EventsResponseModel().obs;
  final leaveAdminResponseModel =
      HolidayAdminResponseModel(leaveList: [], message: '').obs;

  final selectedDay = DateTime.now().obs;

  List<dynamic> getEventsForDay(DateTime day) => [];

  //todo add onError in getshedule as in getmeeting

  getMeeting() async {
    showLoading();
    Get.find<BaseClient>().onError = getMeeting;
    var requestModel = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.meetings, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    print("getMeeting() URL:${ApiEndPoints.meetings}");
    if (responseString == null) {
      return;
    } else {
      print("getMeeting() responseString:" + responseString);
      hideLoading();
      meetingResponseModel.value = meetingResponseModelFromJson(responseString);
      print(
          "meetingResponseModel: ${meetingResponseModel.value.meetingsList?.length.toString()}");
      meetingResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  getHolidays() async {
    showLoading();
    Get.find<BaseClient>().onError = getHolidays;
    var requestModel = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.holidayRequestAdmin, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      leaveAdminResponseModel.value =
          holidayAdminResponseModelFromJson(responseString);
      leaveAdminResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  getEvents() async {
    showLoading();
    Get.find<BaseClient>().onError = getEvents;
    var requestModel = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employerId}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.events, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      eventsResponseModel.value = eventsResponseModelFromJson(responseString);
      eventsResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  getTime(String time) {
    print("Gettime called:$time");
    try {
      final DateTime now = DateTime.parse(time);
      return DateFormat('hh:mm a').format(now).toString();
      // return time;
    } on Exception {
      return '00:00 00';
    }
  }

  timeChange(String inputTime) {
    try {
      final inputFormat = DateFormat('HH:mm');
      final outputFormat = DateFormat('hh:mm a');

      final dateTime = inputFormat.parse(inputTime);
      final formattedTime = outputFormat.format(dateTime);

      return formattedTime;
    } catch (e) {
      // Handle the exception, e.g., log it or return a default value
      print('Error parsing time: $inputTime');
      return 'Invalid Time';
    }
  }
}
