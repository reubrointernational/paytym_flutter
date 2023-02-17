const kBaseUrl = 'http://52.40.210.26:2000/api';
const kMpaisaBaseUrl = 'pay.mpaisa.vodafone.com.fj';
const kDomainUrl = 'petty.ga';

class ApiEndPoints {
  static const login = '$kBaseUrl/login';
  static const logout = '$kBaseUrl/logout';
  static const sendOtp = '$kBaseUrl/send-otp';
  static const confirmOtp = '$kBaseUrl/confirm-otp';
  static const updatePassword = '$kBaseUrl/password-update';
  static const leave = '$kBaseUrl/leave-request';
  static const payslip = '$kBaseUrl/payslip';
  static const checkIn = '$kBaseUrl/check_in';
  static const checkOut = '$kBaseUrl/check_out';
  static const checkInByScan = '$kBaseUrl/check_in_by_scan';
  static const checkOutByScan = '$kBaseUrl/check_out_by_scan';
  static const requestAdvance = '$kBaseUrl/request_advance';
  static const requestPayment = '$kBaseUrl/request_payment';
  static const deductions = '$kBaseUrl/deductions';
  static const meetings = '$kBaseUrl/meetings';
  static const getChat = '$kBaseUrl/get-chat';
  static const sendChat = '$kBaseUrl/send-chat';
  static const quitCompany = '$kBaseUrl/quit_company';
  static const events = '$kBaseUrl/events_list';
  static const sendOtpToEmail = '$kBaseUrl/forgot-password';
  static const confirmOtpWithEmail = '$kBaseUrl/forgotpwd-confirm-otp';
  static const resetPasswordWithEmail = '$kBaseUrl/forgotpwd-password-update';

  static const attendance = '$kBaseUrl/checkin_checkout_list';
  static const leaveRequestAdmin =
      '$kBaseUrl/list_leaves'; // todo change to 'leave_requests_lists'
  static const leaveAcceptReject = '$kBaseUrl/leave_requests_accept_reject';
  static const deleteEvent = '$kBaseUrl/delete_event';
  static const createEvent = '$kBaseUrl/create_event';
}
