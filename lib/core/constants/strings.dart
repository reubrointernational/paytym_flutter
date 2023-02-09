import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/login/login_controller.dart';
import 'icons.dart';

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

List<Map<String, dynamic>> financeDetails = [
  {
    'icon': IconPath.projectIconPng,
    'title': 'Absentees',
    'count': 3,
    'color': Colors.green,
  },
  {
    'icon': IconPath.attendanceIconPng,
    'title': 'Sick leave',
    'count': 1,
    'color': Colors.red,
  },
  {
    'icon': IconPath.absenteesIconPng,
    'title': 'Annual leave',
    'count': 2,
    'color': Colors.orange,
  },
  {
    'icon': IconPath.meetingsIconPng,
    'title': 'Late Arrival',
    'count': 4,
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

List<String> selectMembersTabs = ['Departments ', 'Branches '];

List<Map<String, dynamic>> payrollList = [
  {
    'id': '6386282927',
    'name': 'Akhil Reubro',
    'branch': 'Branch',
    'allowance': 2000,
    'deduction': 500,
    'basic_salary': 15000,
    'tax': 100,
    'gross_salary': 14000,
    'bonus': 200,
    'commission': 500,
    'isExpanded': false,
  },
  {
    'id': '402921927',
    'name': 'Robin Reubro',
    'branch': 'Branch',
    'allowance': 2000,
    'deduction': 500,
    'basic_salary': 15000,
    'tax': 100,
    'gross_salary': 14000,
    'bonus': 200,
    'commission': 500,
    'isExpanded': false,
  },
  {
    'id': '6388882927',
    'name': 'Sreehari Reubro',
    'branch': 'Branch',
    'allowance': 2000,
    'deduction': 500,
    'basic_salary': 15000,
    'tax': 100,
    'gross_salary': 14000,
    'bonus': 200,
    'commission': 500,
    'isExpanded': false,
  },
  {
    'id': '4993483927',
    'name': 'Sooraj Reubro',
    'branch': 'Branch',
    'allowance': 2000,
    'deduction': 500,
    'basic_salary': 15000,
    'tax': 100,
    'gross_salary': 14000,
    'bonus': 200,
    'commission': 500,
    'isExpanded': false,
  },
  {
    'id': '94842927',
    'name': 'Sreejith Reubro',
    'branch': 'Branch',
    'allowance': 2000,
    'deduction': 500,
    'basic_salary': 15000,
    'tax': 100,
    'gross_salary': 14000,
    'bonus': 200,
    'commission': 500,
    'isExpanded': false,
  },
];

List<String> years = ['2018', '2019', '2020', '2021', '2022', '2023', '2024'];

List<String> monthsList = [
  'Jan',
  'Feb',
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

List<String> daysDummyList = [
  '08-02-2023',
  '09-02-2023',
  '10-02-2023',
  '11-02-2023'
];

List<String> branchesDummyData = [
  'Branches 1',
  'Branches 2',
  'Branches 3',
  'Branches 4',
  'Branches 5',
  'Branches 6',
  'Branches 7',
  'Branches 8',
];

List<Map<String, dynamic>> earningsLists = [
  {
    'id': '6386282927',
    'name': 'Akhil Reubro',
    'salary': 50000,
    'branch': 'Branch',
    'days': 23,
  },
  {
    'id': '402921927',
    'name': 'Robin Reubro',
    'salary': 60000,
    'branch': 'Branch',
    'days': 16,
  },
  {
    'id': '6388882927',
    'name': 'Sreehari Reubro',
    'salary': 90000,
    'branch': 'Branch',
    'days': 18,
  },
  {
    'id': '4993483927',
    'name': 'Sooraj Reubro',
    'salary': 40000,
    'branch': 'Branch',
    'days': 22,
  },
  {
    'id': '94842927',
    'name': 'Sreejith Reubro',
    'salary': 70000,
    'branch': 'Branch',
    'days': 20,
  },
];

// List<String> calendarTabList = ['Meeting', 'Event', 'Schedule', 'Holiday'];
List<String> calendarTabList = ['Meeting', 'Event', 'Holiday'];
List<String> leaveTabList = ['All', 'Sick', 'Casual', 'Annual', 'Halfday'];
List<String> leaveTabListAdmin = ['Today', 'Yesterday', 'Pending'];
List<String> reportsTabListAdmin = [
  'Payroll',
  'Wages',
  'Projects',
  'Attendance',
  'Deduction',
  'Medical',
  'Contract period'
];
List<String> reportsTabList = [
  'Split Payment',
  'Payslip',
  'Deduction',
  'Attendance',
  'Health'
];
List<String> financeReportsTabList = [
  'Projects',
  'Deduction',
  'Contract period'
];

const kAppNameString = 'Paytym';

const kPayString = 'Pay';

const ktymString = 'tym';

//Calendar
const kAddString = 'Add';

const kDeleteString = 'Delete';

const kCalendarString = 'Calendar';

const kOctober2022String = 'October 2022';

const kMeetingString = 'Meeting';

const kEventString = 'Event';

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

const kPaySlipString = 'Payslip';

const kDeductionString = 'Deduction';

const kAttendanceString = 'Attendance';

const kReportsString = 'Reports';

const kWorkProfileString = 'Work Profile';

const kEmployeeProfileString = 'Employee Profile';

const kReasonString = 'Reason';

const kTypeTheReasonString = 'Type The Reason';

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
