import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytym/core/constants/icons.dart';

import '../../screens/login/login_controller.dart';

double w = Get.width;
double h = Get.height;

List<Map<String, dynamic>> calendarMeetingDetails = [
  {
    "time": "09:15 AM - 09:45 AM Room 404",
    "person": "Bessie Miles",
    "personJob": "Lead UX / UI Designer, #Studio"
  },
  {
    "time": "10:15 AM - 10:45 AM Room 78",
    "person": "Calvin Cooper",
    "personJob": "Product Designer, Apple Inc."
  },
];
List<Map<String, dynamic>> calendarScheduleDetails = [
  {
    "scheduleOne": [
      {
        "title": "Registration",
        "place": "Entrance Hall",
        "startTime": "09:15 AM",
        "endTime": "09:45 AM",
        "dividerColor": Colors.blue,
      }
    ],
    "scheduleTwo": [
      {
        "title": "Coffee Break",
        "place": "Entrance Hall",
        "startTime": "10:00 AM",
        "endTime": "10:15 AM",
        "dividerColor": Colors.orange,
      }
    ],
  },
  {
    "scheduleOne": [
      {
        "title": "Design thinking",
        "place": "Entrance Hall",
        "startTime": "10:15 AM",
        "endTime": "10:45 AM",
        "dividerColor": Colors.purple,
      }
    ],
    "scheduleTwo": [
      {
        "title": "User flow as a tool",
        "place": "Entrance Hall",
        "startTime": "11:45 AM",
        "endTime": "01:00 PM",
        "dividerColor": Colors.green,
      }
    ],
  },
];

List<Map<String, dynamic>> employeeLeaves = [
  {
    //todo change percentage by calculating
    "bgColor": const Color.fromRGBO(0, 148, 66, 1),
    'total':
        "${Get.find<LoginController>().loginResponseModel?.absence ?? '0'}",
    'icon': Icons.people_outline,
    "title": "Absentees",
    "attendance_percentage": 98,
  },
  {
    "bgColor": const Color.fromRGBO(250, 42, 20, 1),
    //todo change casual to sick leave in api
    'total': "${Get.find<LoginController>().loginResponseModel?.casual ?? '0'}",
    'icon': Icons.text_snippet_outlined,
    "title": "Sick Leave",
    "attendance_percentage": 98,
  },
  {
    "bgColor": const Color.fromRGBO(255, 92, 17, 1),
    'total': "${Get.find<LoginController>().loginResponseModel?.annual ?? '0'}",
    'icon': Icons.event,
    "title": 'Annual Leave',
    "attendance_percentage": 98,
  },
  {
    "bgColor": const Color.fromRGBO(18, 115, 205, 1),
    'total':
        "${Get.find<LoginController>().loginResponseModel?.halfday ?? '0'}",
    'icon': Icons.schedule,
    //todo change halfday to late arrival in api
    "title": 'Late Arrival',
    "attendance_percentage": 98,
  },
];

List<String> leaveTypes = [
  'annual',
  'special',
  'bereavement',
  'maternity',
  'casual',
  'sick',
  'halfday'
];

Map<String, double> datamap = {
  "OnTime": 20,
  "Leaves": 8,
  "Late": 2,
  "EarlyOut": 1,
};

List<Map<String, dynamic>> medicalDetails = [
  {
    'title': 'Medical Condition',
    'subtitle': 'Hypertension',
  },
  {
    'title': 'Allergies & Reaction',
    'subtitle': 'Peanuts',
  },
  {
    'title': 'Medications',
    'subtitle': 'Medicine name',
  },
  {
    'title': 'Blood type',
    'subtitle': 'o+',
  },
  {
    'title': 'Weight',
    'subtitle': '170 lb',
  },
  {
    'title': 'Height',
    'subtitle': "6'2''",
  },
  {
    'title': 'Contacts',
    'subtitle': 'spouse: 9876543232 \ndoctor: 8790695343',
  },
];

List<String> departments = [
  'HR',
  'Sales and marketing',
  'research and development',
  'It services',
  'product development',
  'Accounts and finance'
];

List<String> branches = [
  'Web development',
  'App development',
  'Software testing',
  'Game development',
  'Deployment'
];

List<Map<String, dynamic>> hrDetails = [
  {
    'icon': IconPath.projectIconPng,
    'title': 'Absentees',
    'count': 8,
    'color': Colors.green,
  },
  {
    'icon': IconPath.attendanceIconPng,
    'title': 'Sick leave',
    'count': 2,
    'color': Colors.red,
  },
  {
    'icon': IconPath.absenteesIconPng,
    'title': 'Annual leave',
    'count': 3,
    'color': Colors.orange,
  },
  {
    'icon': IconPath.meetingsIconPng,
    'title': 'Late Arrival',
    'count': 5,
    'color': Colors.blue,
  },
];

List<Map<String, dynamic>> totalEmployeesDetails = [
  {
    'icon': IconPath.projectIconPng,
    'title': 'Total Projects',
    'count': 200,
    'color': Colors.pink,
  },
  {
    'icon': IconPath.attendanceIconPng,
    'title': 'Total Attendance',
    'count': 400,
    'color': Colors.purple,
  },
  {
    'icon': IconPath.absenteesIconPng,
    'title': 'Total Absentees',
    'count': 80,
    'color': Colors.red,
  },
  {
    'icon': IconPath.meetingsIconPng,
    'title': 'Total Meetings',
    'count': 10,
    'color': Colors.orange,
  },
];

List<String> years = [
  '2018 - 19',
  '2019 - 20',
  '2020 - 21',
  '2021 - 22',
  '2022 - 23',
  '2023 - 24',
  '2024 - 25'
];

List<String> monthsTabList = [
  'Jan',
  'Fre',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

List<String> calendarTabList = ['Meeting', 'Event', 'Schedule', 'Holiday'];
List<String> leaveTabList = ['All', 'Sick', 'Casual', 'Annual', 'Halfday'];
List<String> reportsTabList = ['Pay Slip', 'Deduction', 'Attendance', 'Health'];

const kAppNameString = 'Paytym';

const kPayString = 'Pay';

const ktymString = 'tym';

//Calendar
const kEditString = 'Edit';

const kDeleteString = 'Delete';

const kCalendarString = 'Calendar';

const kOctober2022String = 'October 2022';

const kMeetingString = 'Meeting';

const kEventString = 'Event';

const kAddMeetingString = 'Add Meeting';

const kAddEventString = 'Add Event';

const kAddScheduleString = 'Add Schedule';

const kAddHolidayString = 'Add Holiday';

//Chat

const kTypeHereString = 'Type here...';

//Dashboard
const kCheckInOutString = 'CHECK IN/CHECK OUT';

const khrsString = ' hrs';

const kStopString = 'Stop';

const kStartString = 'Start';

const kNowIsString = 'Now is';

const kNextShiftString = 'Next Shift :';

const kSep20String = 'Sep 20';

const k08PMString = '08:00 PM';

//Leaves
const kRequestLeaveString = 'Request Leave';

const kTitleString = 'Title';

const kStartDateString = 'Start date';

const kEndDateString = 'End date';

const kLeavesString = 'Leaves';

const kAllString = 'All';

const kcasualString = 'casual';

const kOtherString = 'Other';

const kSickString = 'Sick';

const ksickString = 'sick';

//Login
const kForgotPasswordString = 'Forgot Password?';

const kDontWorryString =
    'Don\'t worry! It happens. Please enter the address associated with your account';

const kEmailString = 'Email';

const kSendString = 'Send';

const kLogInString = 'Login';

const kPasswordString = 'Password';

const kOTPString = 'OTP';

const kEnterTheOTPString = 'Enter the OTP send to your email';

const kSubmitString = 'Submit';

const kResetPasswordString = 'Reset Password';

const kNewPasswordString = 'New Password';

const kConfirmPasswordString = 'Confirm Password';

//Reports
const kHistoryString = 'History';

const kDateString = 'Date: ';

const kPunchInString = 'Punch In: ';

const kPunchOutString = 'Punch Out: ';

const kDeductionsString = 'Deductions';

const kFundDeductionsString = 'Fund deductions';

const kProfessionalTaxString = 'Professional Tax';

const kTotalString = 'Total';

const kNetPayString = 'Net Pay:';

const kPaySlipString = 'Pay Slip';

const kDeductionString = 'Deduction';

const kAttendanceString = 'Attendance';

const kReportsString = 'Reports';

const kRequestPaymentString = 'Request Payment';

const kQuitCompanyString = 'Quit Company';

const kWhyDoYouWantToQuitTheCompany = 'Why do you want to quit the company?';

const kRequestAdvanceString = 'Request Advance';

const kLogoutString = 'Logout';

const kAmountString = 'Amount';

const kDescString = 'Description';

const kSalaryString = 'Salary';

const kReportString = 'Report';

//Scan
const kDataString = 'Data:';

const kScanString = 'Scan';

const kScanCodeString = 'Scan Code';
