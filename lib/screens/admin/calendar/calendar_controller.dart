import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/calendar/create_event_request_model.dart';
import 'package:paytym/models/calendar/events_respnse_model.dart';
import 'package:paytym/models/calendar/meeting_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../core/dialog_helper.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';

class CalendarControllerAdmin extends GetxController with BaseController {
  final selectedCalendarTab = CalendarTabs.meeting.obs;
  final meetingResponseModel = MeetingResponseModel().obs;
  final eventsResponseModel = EventsResponseModel().obs;
  final selectedCalendarDropdown = calendarTabList.first.obs;

  final selectedDay = DateTime.now().obs;
  final picker = ''.obs;

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  List<dynamic> getEventsForDay(DateTime day) => ['HI'];

  //todo add onError in getshedule as in getmeeting

  getMeeting() async {
    showLoading();
    Get.find<BaseClient>().onError = getMeeting;
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.meetings, null,
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      meetingResponseModel.value = meetingResponseModelFromJson(responseString);
      meetingResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  Future<void> getEvents() async {
    showLoading();
    Get.find<BaseClient>().onError = getEvents;
    var requestModel = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employer_id}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.events, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      eventsResponseModel.value = eventsResponseModelFromJson(responseString)!;
      eventsResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  deleteEvent(int index) async {
    showLoading();
    var requestModel = {
      'id': '${eventsResponseModel.value.events![index]!.id}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.deleteEvent, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      eventsResponseModel.value.events?.removeAt(index);
      eventsResponseModel.refresh();
    }
  }

  createCalendarItems() {
    if (selectedCalendarDropdown.value == calendarTabList.first) {
      
      createEvent(); //todo create meeting
    } else if (selectedCalendarDropdown.value == calendarTabList[1]) {
      
      createEvent();  
    } else {
      
      createEvent();  //todo create holiday
    }
  }

  createEvent() async {
    showLoading();
    var model = CreateEventRequestModel(
      employerId: Get.find<LoginController>()
          .loginResponseModel!
          .employee!
          .employer_id
          .toString(),
      name: 'name',
      description: 'description',
      place: 'place',
      startDate: '2023-01-15',
      startTime: '11:00 am',
      endDate: '2023-01-15',
      endTime: '11:00 am',
    );
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.createEvent, createEventRequestModelToJson(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      await getEvents();
      Get.back();
    }
  }

  getTime(String time) {
    final DateTime now = DateTime.parse(time);
    return DateFormat('hh:mm a').format(now);
  }

  @override
  void onReady() {
    super.onReady();
    getMeeting();
    getEvents();
  }
}
