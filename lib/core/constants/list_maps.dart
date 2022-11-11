import '../../models/report/report_dropdown_model.dart';
import 'enums.dart';
import 'strings.dart';

List<ReportDropDownModel> kReportDropDownItemList = [
  ReportDropDownModel(kRequestPaymentString, ReportsDropDown.payment),
  ReportDropDownModel(kRequestAdvanceString, ReportsDropDown.advance),
  ReportDropDownModel(kQuitCompanyString, ReportsDropDown.quit),
  ReportDropDownModel(kLogoutString, ReportsDropDown.logout),
];
