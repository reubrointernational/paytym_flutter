import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/calendar/events_respnse_model.dart';
import 'package:paytym/models/calendar/meeting_response_model.dart';
import 'package:paytym/network/base_controller.dart';
import 'package:paytym/screens/employee/calendar/widgets/add_meeting_dialogue.dart';

import '../../../core/constants/enums.dart';
import '../../../core/dialog_helper.dart';
import '../../../network/base_client.dart';
import '../../../network/end_points.dart';
import '../../login/login_controller.dart';
import '../dashboard/widgets/request_advance_bottomsheet.dart';


class CalendarController extends GetxController with BaseController {
  final selectedCalendarTab = CalendarTabs.meeting.obs;
  final meetingResponseModel = MeetingResponseModel().obs;
  final eventsResponseModel = EventsResponseModel().obs;
  final picker = ''.obs;

  final selectedDay = DateTime.now().obs;

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

  getEvents() async {
    showLoading();
    Get.find<BaseClient>().onError = getEvents;
    var responseString = await Get.find<BaseClient>()
        .get(ApiEndPoints.events, Get.find<LoginController>().getHeader())
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

  ImagePicker imagePicker = ImagePicker();

  Future<void> uploadProfileImageFromCamera() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      DialogHelper.showToast(desc: 'No image selected');
    } else {
      picker.value = image.path;
    }
    Get.back();
  }

  Future<void> uploadProfileImageFromGallery() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      DialogHelper.showToast(desc: 'No image selected');
    } else {
      picker.value = image.path;
    }
    Get.back();
  }
}
