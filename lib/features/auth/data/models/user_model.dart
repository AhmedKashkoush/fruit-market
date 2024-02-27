import 'package:fruit_market/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.imgUrl,
    required super.gender,
    required super.address,
    super.birthday,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'] ?? '',
        imgUrl: json['imgUrl'],
        gender: json['gender'] ?? '',
        address: json['address'],
        birthday: DateTime.tryParse(json['birthday']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'imgUrl': imgUrl,
        'gender': gender,
        'address': address,
        'birthday': birthday?.millisecondsSinceEpoch.toString(),
      };
}
