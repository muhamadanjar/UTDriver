class User {
  final String username;
  final String password;
  final String token;
  User({this.username, this.password,this.token});

  String get _username => username;
  String get _password => password;

  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      token: json['token'],
    );
  }

  // User.map(dynamic obj) {
  //   this._username = obj["username"];
  //   this._password = obj["password"];
  // }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    map['token'] = token;

    return map;
  }

}