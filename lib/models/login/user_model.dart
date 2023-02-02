class UserModel {
  UserModel({
    this.email = '',
    this.confirmPassword = '',
    this.otp,
    this.password = '',
  });
  String email = '';
  String password = '';
  String confirmPassword = '';
  String? otp = '';
}
