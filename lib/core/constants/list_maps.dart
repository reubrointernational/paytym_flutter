import '../../models/calendar/calendar_dropdown_model.dart';
import '../../models/report/report_dropdown_model.dart';
import 'enums.dart';
import 'strings.dart';

List<ReportDropDownModel> kReportDropDownItemList = [
  //ReportDropDownModel(kRequestPaymentString, ReportsDropDown.payment),
  ReportDropDownModel(kRequestAdvanceString, ReportsDropDown.advance),
  //ReportDropDownModel(kQuitCompanyString, ReportsDropDown.quit),
  ReportDropDownModel(kLogoutString, ReportsDropDown.logout),
];

List<CalendarDropDownModel> kCalendarDropDownItemList = [
  CalendarDropDownModel(kAddMeetingString, CalendarTabs.meeting),
  CalendarDropDownModel(kAddEventString, CalendarTabs.events),
  CalendarDropDownModel(kAddScheduleString, CalendarTabs.schedule),
  CalendarDropDownModel(kAddHolidayString, CalendarTabs.holiday),
];
