import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'icons.dart';

double w = Get.mediaQuery.size.width;
double h = Get.mediaQuery.size.height;

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
    "bgColor": const Color.fromRGBO(0, 148, 66, 1),
    'icon': Icons.people_outline,
    "title": "Absent",
  },
  {
    "bgColor": const Color.fromRGBO(250, 42, 20, 1),
    'icon': Icons.text_snippet_outlined,
    "title": "Sick Leave",
  },
  {
    "bgColor": const Color.fromRGBO(255, 92, 17, 1),
    'icon': Icons.event,
    "title": 'Annual Leave',
  },
  {
    "bgColor": const Color.fromRGBO(18, 115, 205, 1),
    'icon': Icons.schedule,
    "title": 'Late Arrival',
  },
];

// List<String> leaveTypes = [
//   'annual',
//   'special',
//   'bereavement',
//   'maternity',
//   'casual',
//   'sick',
//   'halfday'
// ];

final medicalList = [
  'Medical condition',
  'Allergies & Reaction',
  'Blood type',
  'Weight'
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

List<String> selectMembersTabs = ['Departments ', 'Branches ', 'Business '];

List<String> selectMembersTabsAttendance = [
  'Business ', 'Branches ', 'Departments ', 'Bank '
];

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
    'processValue': 100.0,
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
    'processValue': 100.0,
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
    'processValue': 100.0,
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
    'processValue': 100.0,
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
    'processValue': 100.0,
  },
];

List<String> years = ['2023', '2022', '2021', '2020', '2019'];

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

List<String> payrollTabList = ['Pending', 'Payment'];

List<Map<String, dynamic>> chatList = [
  {
    'name': 'Robin Reubro',
    'last_message': 'Hai, how is the project status',
    'date': '01/02/2023',
  },
  {
    'name': 'Akhil Reubro',
    'last_message': 'Please finish pending works',
    'date': '01/02/2023',
  },
  {
    'name': 'Sreehari Reubro',
    'last_message': 'Finished the paytym designs',
    'date': '01/02/2023',
  },
  {
    'name': 'Sooraj Reubro',
    'last_message': 'please check new server link',
    'date': '02/02/2023',
  },
];

// List<String> calendarTabList = ['Meeting', 'Event', 'Schedule', 'Holiday'];
List<String> calendarTabList = ['Meeting', 'Event', 'Holiday'];
// List<String> leaveTabList = ['All', 'Sick', 'Casual', 'Annual', 'Halfday'];
List<String> leaveTabListAdmin = [
  'Pending',
  'All',
  'Today',
  'Yesterday',
];

List<String> reportsTabList = [
  'Attendance',
  'Overtime',
  'Split Payment',
  'Deduction',
  'Payslip',
  'My Files',
  'Medical'
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

const kHalfDayString = 'halfday';

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

const kCheckInString = 'Check In: ';

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

const kProcessPayrollString = 'Process Payroll';

const kEmployeeProfileString = 'Employee Profile';

const kReasonString = 'Reason';

const kTypeTheReasonString = 'Type The Reason';

const kRequestAdvanceString = 'Request Advance';

const kRequestOvertimeString = 'Request Overtime';

const kEditOvertimeString = 'Edit Overtime';

const kLogoutString = 'Logout';

const kAmountString = 'Amount';

const kStartTimeString = 'Start time';

const kTotalHoursString = 'Total hours';

const kEndTimeString = 'End time';

const kSalaryString = 'Salary';

const kReportString = 'Report';

//Scan
const kDataString = 'Data:';

const kScanString = 'Scan';

const kScanCodeString = 'Scan Code';
