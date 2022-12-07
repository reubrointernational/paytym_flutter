import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytym/models/calendar/meeting_response_model.dart';
import 'package:paytym/network/base_controller.dart';

import '../../core/constants/enums.dart';
import '../../network/base_client.dart';
import '../../network/end_points.dart';
import '../login/login_controller.dart';

class CalendarController extends GetxController with BaseController {
  final selectedCalendarTab = CalendarTabs.meeting.obs;
  final meetingResponseModel = MeetingResponseModel().obs;

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

  getTime(String time) {
    final DateTime now = DateTime.parse(time);
    return DateFormat('hh:mm a').format(now);
  }

  @override
  void onReady() {
    super.onReady();
    getMeeting();
  }
}
