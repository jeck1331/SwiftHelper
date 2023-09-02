import 'login.dart';

class Register extends Login {
  Register(
      {required super.userName,
      required super.password,
      required this.confirmPassword, required this.email, this.phoneNumber});

  final String email;
  String? phoneNumber;
  final String confirmPassword;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        userName: json["userName"],
        password: json["password"],
        email: json["email"],
        confirmPassword: json["confirmPassword"]
      );

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
    'email': email,
        'confirmPassword': confirmPassword
      };
}
