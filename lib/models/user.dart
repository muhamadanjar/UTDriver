class User {
  final String id;
  final String email;
  final String username;
  final String password;
  final String name;
  String token;
  final double rating;
  final int trip;
  final String photoUrl;
  int saldo;
  User({this.id,this.email,this.username, this.password,this.token,this.name,this.rating,this.trip,this.saldo,this.photoUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id:json['id'],
      username: json['username'],
      email: json['username'],
      password: json['password'],
      name: json['name'],
      rating: json['rating'],
      trip: json['trip'],
      token: json['api_token'],
      saldo: json['wallet'],
      photoUrl: json['foto']
    );
  }

  // User.map(dynamic obj) {
  //   this._username = obj["username"];
  //   this._password = obj["password"];
  // }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["name"] = password;
    map["password"] = password;
    map['token'] = token;

    return map;
  }

}