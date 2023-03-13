import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
    if (meetingResponseModel.value.message?.isEmpty ?? true) {
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
      if (responseString == null) {
        return;
      } else {
        hideLoading();
        meetingResponseModel.value =
            meetingResponseModelFromJson(responseString);
        meetingResponseModel.refresh();
        Get.find<BaseClient>().onError = null;
      }
    }
  }

  getHolidays() async {
    if (leaveAdminResponseModel.value.message.isEmpty) {
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
  }

  getEvents() async {
    if (eventsResponseModel.value.message?.isEmpty ?? true) {
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
        eventsResponseModel.value =
            eventsResponseModelFromJson(responseString);
        eventsResponseModel.refresh();
        Get.find<BaseClient>().onError = null;
      }
    }
  }

  getTime(String time) {
    final DateTime now = DateTime.parse(time);
    return DateFormat('hh:mm a').format(now);
  }

  @override
  void onReady() {
    super.onReady();
    //getMeeting();
    getEvents();
    //getHolidays();
  }
}
