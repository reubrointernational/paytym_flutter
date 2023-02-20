import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/calendar/create_calendar_request_model.dart';
import 'package:paytym/models/calendar/events_respnse_model.dart';
import 'package:paytym/models/calendar/meeting_list_admin_model.dart';
import 'package:paytym/models/calendar/meeting_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import '../../../core/constants/enums.dart';
import '../../../core/constants/strings.dart';
import '../../../models/calendar/holiday_admin_response_model.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';

class CalendarControllerAdmin extends GetxController with BaseController {
  final selectedCalendarTab = CalendarTabs.meeting.obs;
  final meetingResponseModel =
      MeetingListAdminModel(message: '', meetingsListe: []).obs;
  final eventsResponseModel = EventsResponseModel().obs;
  final selectedCalendarDropdown = calendarTabList.first.obs;
  final formKey = GlobalKey<FormState>();
  final leaveAdminResponseModel =
      HolidayAdminResponseModel(leaveList: [], message: '').obs;
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
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  List<dynamic> getEventsForDay(DateTime day) => ['HI'];

  getMeeting() async {
    showLoading();
    Get.find<BaseClient>().onError = getMeeting;
    var requestModel = {
      'employer_id': 
      '${Get.find<LoginController>().loginResponseModel?.employee?.employer_id}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.meetingsList, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      meetingResponseModel.value =
          meetingListAdminModelFromJson(responseString);
      meetingResponseModel.refresh();
      Get.find<BaseClient>().onError = null;
    }
  }

  deleteMeeting(int index) async {
    // showLoading();
    // var requestModel = {
    //   'id': '${eventsResponseModel.value.events![index]!.id}'
    // };
    // var responseString = await Get.find<BaseClient>()
    //     .post(ApiEndPoints.deleteEvent, jsonEncode(requestModel),
    //         Get.find<LoginController>().getHeader())
    //     .catchError(handleError);
    // if (responseString == null) {
    //   return;
    // } else {
    //   hideLoading();
    //   eventsResponseModel.value.events?.removeAt(index);
    //   eventsResponseModel.refresh();
    // }
  }

  String formatTimeOfDay(TimeOfDay? tod) {
    final now = DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, tod?.hour ?? 00, tod?.minute ?? 00);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
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

  getHolidays() async {
    showLoading();
    Get.find<BaseClient>().onError = getHolidays;
    var requestModel = {
      'employer_id':
          '${Get.find<LoginController>().loginResponseModel?.employee?.employer_id}'
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
      Get.find<BaseClient>().onError = null;
    }
  }

  deleteHoliday(int index) async {
    showLoading();
    var requestModel = {
      'id': '${leaveAdminResponseModel.value.leaveList[index].id}'
    };
    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.deleteHoliday, jsonEncode(requestModel),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    if (responseString == null) {
      return;
    } else {
      hideLoading();
      leaveAdminResponseModel.value.leaveList.removeAt(index);
      leaveAdminResponseModel.refresh();
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
        createHoliday();
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
      description: 'description',
      place: createCalendarRequestModel.place,
      startDate: createCalendarRequestModel.startDate, //2023-01-15
      startTime: createCalendarRequestModel.startTime, //11:00 am
      endDate: createCalendarRequestModel.endDate, //2023-01-15
      endTime: createCalendarRequestModel.endTime, //11:00 am
    );

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.createEvent, createEventRequestModelToJson(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      await getEvents();
      Get.back();
      startDateController.clear();
      endDateController.clear();
      endTimeController.clear();
      startTimeController.clear();
    }
  }

  createHoliday() async {
    showLoading();

    var model = CreateCalendarRequestModel(
      employerId: Get.find<LoginController>()
          .loginResponseModel!
          .employee!
          .employer_id
          .toString(),
      name: createCalendarRequestModel.name,
      description: 'description',
      place: createCalendarRequestModel.place,
      startDate: createCalendarRequestModel.startDate, //2023-01-15
      startTime: createCalendarRequestModel.startTime, //11:00 am
      endDate: createCalendarRequestModel.endDate, //2023-01-15
      endTime: createCalendarRequestModel.endTime, //11:00 am
      type: '1',
      countryId: '1',
    );

    var responseString = await Get.find<BaseClient>()
        .post(ApiEndPoints.createHoliday, createEventRequestModelToJson(model),
            Get.find<LoginController>().getHeader())
        .catchError(handleError);
    hideLoading();
    if (responseString == null) {
      return;
    } else {
      await getHolidays();
      Get.back();
      startDateController.clear();
      endDateController.clear();
      endTimeController.clear();
      startTimeController.clear();
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
    getHolidays();
  }

  String? subjectValidator(String value, String title) {
    return GetUtils.isLengthLessThan(value, 3)
        ? "$title should be minimum 3 characters"
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

  String? dateValidator(String value) {
    final regExp =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\-(0[1-9]|1[012])\-\d{4}$');
    return regExp.hasMatch(value) && GetUtils.isLengthEqualTo(value, 10)
        ? null
        : "Enter a valid date";
  }
}
