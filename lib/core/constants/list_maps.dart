import '../../models/calendar/calendar_dropdown_model.dart';
import '../../models/report/report_dropdown_model.dart';
import 'enums.dart';
import 'strings.dart';

List<ReportDropDownModel> kReportDropDownItemList = [
  ReportDropDownModel(kWorkProfileString, DashboardDropDown.workProfile),
  ReportDropDownModel(kRequestAdvanceString, DashboardDropDown.advance),
  ReportDropDownModel(kLogoutString, DashboardDropDown.logout),
];

List<ReportDropDownModel> kReportDropDownItemListWithoutAdvance = [
  ReportDropDownModel(kEmployeeProfileString, DashboardDropDown.employeeProfile),
  ReportDropDownModel(kLogoutString, DashboardDropDown.logout),
];
