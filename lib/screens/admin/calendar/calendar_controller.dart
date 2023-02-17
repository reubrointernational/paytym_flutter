import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/calendar/create_calendar_request_model.dart';
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
  final formKey = GlobalKey<FormState>();
  CreateCalendarRequestModel createCalendarRequestModel =
      CreateCalendarRequestModel(
    employerId: '',
    name: '',
    description: '',
    place: '',
    startDate: '',
    startTime: '',
    endDate: '',
    endTime: '',
  );

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
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (selectedCalendarDropdown.value == calendarTabList.first) {
        createEvent(); //todo create meeting
      } else if (selectedCalendarDropdown.value == calendarTabList[1]) {
        createEvent();
      } else {
        createEvent(); //todo create holiday
      }
    }
  }

  createEvent() async {
    showLoading();
    var model = CreateCalendarRequestModel(
      employerId: Get.find<LoginController>()
          .loginResponseModel!
          .employee!
          .employer_id
          .toString(),
      name: createCalendarRequestModel.name,
      description: createCalendarRequestModel.description,
      place: createCalendarRequestModel.place,
      startDate: createCalendarRequestModel.startDate, //2023-01-15
      startTime: createCalendarRequestModel.startTime, //11:00 am
      endDate: createCalendarRequestModel.endDate,     //2023-01-15
      endTime: createCalendarRequestModel.endTime,     //11:00 am
    );

    // var responseString = await Get.find<BaseClient>()
    //     .post(ApiEndPoints.createEvent, createEventRequestModelToJson(model),
    //         Get.find<LoginController>().getHeader())
    //     .catchError(handleError);
    // if (responseString == null) {
    //   return;
    // } else {
    //   hideLoading();
    //   await getEvents();
    //   Get.back();
    // }
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

  String? subjectValidator(String value, String title) {
    return GetUtils.isLengthLessThan(value, 5)
        ? "$title should be minimum 5 characters"
        : null;
  }

  Future<void> selectDateTime(BuildContext context, bool isStartDate) async {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();
    final DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: isStartDate ? DateTime(1990) : startDate,
      lastDate: DateTime(2030),
    );
    isStartDate ? startDate = dateTime! : endDate = dateTime!;

    isStartDate
        ? startDateController.text = getDateString(startDate)
        : endDateController.text = getDateString(endDate);

    isStartDate
        ? createCalendarRequestModel.startDate = getReverseDateString(startDate)
        : createCalendarRequestModel.endDate = getReverseDateString(endDate);
  }

  String getDateString(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    return DateFormat('dd-MM-yyyy').format(dateTime).toString();
  }

  String getReverseDateString(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    return DateFormat('yyyy-MM-dd').format(dateTime).toString();
  }

  String? dateValidator(String value) {
    final regExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\-(0[1-9]|1[012])\-\d{4}$');
    return regExp.hasMatch(value) && GetUtils.isLengthEqualTo(value, 10)
        ? null
        : "Enter a valid date";
  }
}
