import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.email,
    required this.password,
  });

  String id;
  String name;
  int phone;
  String image;
  String email;
  String password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"] != null ? int.parse(json["phone"].toString()) : 0,
        image: json["image"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "image": image,
        "email": email,
        "password": password,
      };

  UserModel copyWith({
    String? name,
    int? phone,
    String? image,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
