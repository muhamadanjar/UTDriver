class UserLogin {
  
  final String username;
  final String password;

  UserLogin({this.username, this.password});

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      username: json['username'],
      password: json['password'],
    );
  }
}