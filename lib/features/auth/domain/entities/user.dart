import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name, email, phone, imgUrl, gender, address;
  final DateTime? birthday;

  const User({
    required this.name,
    required this.email,
    required this.phone,
    required this.imgUrl,
    required this.gender,
    required this.address,
    this.birthday,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        imgUrl,
        gender,
        address,
        birthday,
      ];
}
