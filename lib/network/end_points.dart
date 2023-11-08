// const kBaseUrl = 'http://52.40.210.26:2000/api';
// const kStorageUrl = 'http://52.40.210.26:2000/storage/';

const kBaseUrl = 'https://paytym.net/api';
const kStorageUrl = 'https://paytym.net/storage/pdfs/';

const kBaseUrls = 'https://paytym.net/api';
const kStorageUrlForPDF = 'https://paytym.net/storage/pdfs/';

const kBaseUrl1 = 'https://paytym.net/api';
const kStorageUrlForProfileImage = 'https://paytym.net/storage/';

// const kStorageUrl = 'https://paytym.net/storage/';
// const kStorageUrl = 'https://paytym.net/file/';

// const kBaseUrl = 'http://192.168.1.35:8000/api';
// const kStorageUrl = 'http://192.168.1.35:8000/storage/';

// const kStorageUrl = 'http://192.168.1.13:8000/storage/';
const kMpaisaBaseUrl = 'pay.mpaisa.vodafone.com.fj';
const kDomainUrl = 'paytym.net';

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
  static const employeeAttendance = '$kBaseUrl/attendance';
  static const meetings = '$kBaseUrl/meetings';
  static const getChat = '$kBaseUrl/chat_group_detais';
  static const sendChat = '$kBaseUrl/send-chat';
  static const quitCompany = '$kBaseUrl/quit_company';
  static const events = '$kBaseUrl/events_list';
  static const sendOtpToEmail = '$kBaseUrl/forgot-password';
  static const confirmOtpWithEmail = '$kBaseUrl/forgotpwd-confirm-otp';
  static const resetPasswordWithEmail = '$kBaseUrl/forgotpwd-password-update';
  static const attendance = '$kBaseUrl/checkin_checkout_list';
  static const holidayRequestAdmin = '$kBaseUrl/list_leaves';
  static const leaveAcceptReject = '$kBaseUrl/leave_requests_accept_reject';
  static const deleteEvent = '$kBaseUrl/delete_event';
  static const createEvent = '$kBaseUrl/create_event';
  static const deleteHoliday = '$kBaseUrl/delete_leave';
  static const createHoliday = '$kBaseUrl/create_leaves';
  static const attendanceAcceptReject = '$kBaseUrl/attendance_approve_reject';
  static const attendanceEdit = '$kBaseUrl/attendance_edit';
  static const leaveRequestAdmin = '$kBaseUrl/leave_requests_lists';
  static const deductionsList = '$kBaseUrl/deductions_list';
  static const meetingsList = '$kBaseUrl/list_meetings';
  static const medicalList = '$kBaseUrl/extra_details';
  static const splitPayment = '$kBaseUrl/split_payment';
  static const splitPaymentList = '$kBaseUrl/split_payment_list';

  static const createMeetings = '$kBaseUrl/create_meetings';
  static const deleteMeetings = '$kBaseUrl/meetings_delete';
  static const getOvertime = '$kBaseUrl/list_overtime';
  static const approveOvertime =
      '$kBaseUrl/overtime_request_approve_decline_edit';
  static const approveAdvance =
      '$kBaseUrl/advance_request_approve_decline_edit';
  static const approveOvertimeHR = '$kBaseUrl/hr_store_overtime';
  static const deductionDelete = '$kBaseUrl/deductions_delete';
  static const deductionAdd = '$kBaseUrl/deductions_add';
  static const employeeList = '$kBaseUrl/list_employees';
  static const getAdvance = '$kBaseUrl/list_advance_request';
  static const chatGroupList = '$kBaseUrl/chat_group';
  static const createChatGroup = '$kBaseUrl/create_chat_groups';
  static const projectsList = '$kBaseUrl/list_projects';
  static const branchDeptList = '$kBaseUrl/list_branch_departments';
  static const employeeFileList = '$kBaseUrl/list_files';
  static const fileTypeList = '$kBaseUrl/list_file_types';
  static const fileTypeListEmployee = '$kBaseUrl/list_employee_file_types';

  static const processPayroll = '$kBaseUrl/payroll-calculation';
  static const revertPayroll = '$kBaseUrl/revert_payroll';
  static const adminDashboard = '$kBaseUrl/admin_dashboard';
  static const dashboard = '$kBaseUrl/dashboard';
  static const uploadFiles = '$kBaseUrl/upload_files';
  static const uploadFilesEmployee = '$kBaseUrl/employee_upload_files';

  static const leaveTypes = '$kBaseUrl/get-leave-types';
  static const updateFCMToken = '$kBaseUrl/apply_device_id';

  static const fetchBusiness = '$kBaseUrl/get_business';
  static const fetchDepartment = '$kBaseUrl/get_department';
  static const fetchBranch = '$kBaseUrl/get_branch';

  static const fetchEmployeesDepartmentWise =
      '$kBaseUrl/list_employees_departmentwise';
  static const fetchEmployeesBranchWise = '$kBaseUrl/list_employees_branchwise';

  static const attendanceByHr = '$kBaseUrl/attendance_by_hr';
  static const fetchEmployeesBusinessWise =
      '$kBaseUrl/list_employees_businesswise';
}
