import '../../models/dashboard/dashboard_dropdown_model.dart';
import 'enums.dart';
import 'strings.dart';

List<DashboardDropDownModel> kDashboardDropDownItemList = [
  DashboardDropDownModel(kWorkProfileString, DashboardDropDown.workProfile),
  DashboardDropDownModel(kRequestAdvanceString, DashboardDropDown.advance),
  DashboardDropDownModel(kRequestOvertimeString, DashboardDropDown.overTime),
  DashboardDropDownModel(kLogoutString, DashboardDropDown.logout),
];

List<DashboardDropDownModel> kReportDropDownItemListWorkProfile = [
  DashboardDropDownModel(
      kEmployeeProfileString, DashboardDropDown.employeeProfile),
  DashboardDropDownModel(kLogoutString, DashboardDropDown.logout),
];
