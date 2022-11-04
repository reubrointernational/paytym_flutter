class UserModel {
  UserModel(
      {this.email = '',
      this.confirmPassword = '',
      this.otp,
      this.password = '',
      this.token});
  String email = '';
  String password = '';
  String confirmPassword = '';
  String? token = '';
  String? otp = '';
}
