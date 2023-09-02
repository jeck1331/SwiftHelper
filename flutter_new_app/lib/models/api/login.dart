class Login {
  const Login({
    required this.userName,
    required this.password,
  });

  final String userName;
  final String password;

  Map<String, dynamic> toJson() => {'userName': userName, 'password': password};

  factory Login.fromJson(Map<String, dynamic> json) =>
      Login(userName: json["userName"], password: json["password"]);
}
