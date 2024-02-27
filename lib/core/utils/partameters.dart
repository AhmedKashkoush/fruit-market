class LoginParams {
  final String email, password;

  const LoginParams({required this.email, required this.password});
}

class SignUpParams {
  final String name, email, password, phone, imgUrl, gender, address;
  final DateTime? birthday;

  const SignUpParams({
    required this.name,
    required this.email,
    this.phone = '',
    this.imgUrl = '',
    required this.gender,
    required this.address,
    this.birthday,
    required this.password,
  });
}
