// import 'dart:convert';

// import 'package:samay_mvp/models/timestamped_model/timestamped_model.dart';

// AdminModel adminModelFromJson(String str) =>
//     AdminModel.fromJson(json.decode(str));

// String adminModelToJson(AdminModel data) => json.encode(data.toJson());

// class AdminModel {
//   AdminModel(
//     this.id,
//     this.name,
//     this.email,
//     this.number,
//     this.password,
//     this.createTime, {
//     this.image = "",
//   });

//   String id;
//   String name;
//   String email;
//   int number;
//   String password;
//   String? image;
//   List<TimestampedModel> createTime;

//   factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
//         json["id"],
//         json["name"],
//         json["email"],
//         json["number"] != null ? int.parse(json["number"].toString()) : 0,
//         json["password"],
//         (json["createTime"] as List)
//             .map((item) => TimestampedModel.fromJson(item))
//             .toList(),
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "number": number,
//         "password": password,
//         "image": image,
//       };

//   // AdminModel copyWith({
//   //   String? name,
//   //   image,
//   //   email,
//   //   password,
//   //   number,
//   // }) =>
//   // AdminModel(
//   //   id: id,
//   //   name: name ?? this.name,
//   //   email: email ?? this.email,
//   //   image: image ?? this.image,
//   //   password: password ?? this.password,
//   //   number: number ?? this.number,
//   // );
// }
