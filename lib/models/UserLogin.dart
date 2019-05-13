class UserLogin {
  
  String username;
  String password;
  String token;
  String avatar;
  String firstname;
  String lastname;
  int id;

  UserLogin({
    this.token,
    this.avatar,
    this.firstname,
    this.password,
    this.username,
    this.id,
    this.lastname,
  });
  
  UserLogin.map(dynamic obj) {
    this.username = obj["username"];
    this.password = obj["password"];
  }

    factory UserLogin.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

    Map<String, dynamic> toJson() => _$UserToJson(this);

    @override
    String toString() {
      return "$firstname $lastname".toString();
    }
  
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;

    return map;
  }


  
}

UserLogin _$UserFromJson(Map<String, dynamic> json) {
  return UserLogin(
      token: json['token'] as String,
      avatar: json['avatar'] as String,
      firstname: json['first_name'] as String,
      id: json['id'] as int,
      lastname: json['last_name'] as String);
}

  Map<String, dynamic> _$UserToJson(UserLogin instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'avatar': instance.avatar,
      'token': instance.token
    };