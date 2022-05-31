class UserModel {
  String? userName;
  String? email;
  String? password;
  String? uid;

  UserModel({
    this.userName,
    this.email,
    this.password,
    this.uid,
  });

  factory UserModel.fromJson(dynamic json) => UserModel(
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        uid: json.id,
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "password": password,
      };
}
