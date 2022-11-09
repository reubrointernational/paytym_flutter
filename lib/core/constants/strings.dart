import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    "bgColor": Colors.green,
    'total': 10,
    'icon': Icons.people_outline,
    "title": "Absentees",
    "attendance_percentage": 98,
  },
  {
    "bgColor": Colors.red,
    'total': 05,
    'icon': Icons.text_snippet_outlined,
    "title": "Sick Leave",
    "attendance_percentage": 98,
  },
  {
    "bgColor": Colors.orange,
    'total': 12,
    'icon': Icons.event,
    "title": "Annual Leave",
    "attendance_percentage": 98,
  },
  {
    "bgColor": Colors.blue,
    'total': 04,
    'icon': Icons.schedule,
    "title": "Late Arrival",
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

const kAppNameString = 'Paytym';

const kPayString = 'Pay';

const ktymString = 'tym';

//Calendar
const kRescheduleString = 'Reschedule';

const k8amString = '08:00 AM';

const kCalendarString = 'Calendar';

const kOctober2022String = 'October 2022';

const kMeetingString = 'Meeting';

const kScheduleString = 'Schedule';

//Chat
const kHiJimmyString = 'Hi, Jimmy! any update today? please come today as well';

const kAllgoodString =
    'All good! we have some update  please come today as well';

const kDarleneRobertsonString = 'Darlene Robertson';

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

const kCasualString = 'Casual';

const kSickString = 'Sick';

const ksickString = 'sick';

//Login
const kForgotPasswordString = 'Forgot Password?';

const kDontWorryString =
    'Don\'t worry! It happens. Please enter the address associated with your account';

const kEmailString = 'Email';

const kSendString = 'Send';

const kLogInString = 'Log In';

const kPasswordString = 'Password';

const kOTPString = 'OTP';

const kEnterTheOTPString = 'Enter the OTP send to your number';

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

const kRequestAdvanceString = 'Request Advance';

const kLogoutString = 'Logout';

const kNameString = 'Name';

const kEmployeeIDString = 'Employee ID';

const kAmountString = 'Amount';

const kReportString = 'Report';

//Scan
const kDataString = 'Data:';

const kScanCodeString = 'Scan Code';
