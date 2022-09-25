// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponse {
  bool success;
  String userStatus;
  String msg;
  String token;
  LoginResponse({
    required this.success,
    required this.userStatus,
    required this.msg,
    required this.token,
  });

}
