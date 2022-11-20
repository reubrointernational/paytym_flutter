const kBaseUrl = 'http://52.40.210.26:2000/api';

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
}
