
class UserLoginModel {
  final String email;
  final String password;
  int loginCount;

  /// Constructs a [UserLoginModel] instance with required email and password.
  ///
  /// The [loginCount] parameter specifies the interaction count, defaulting to 1.
  UserLoginModel({required this.email, required this.password, this.loginCount = 1});

  /// Converts the [UserLoginModel] instance to a map for serialization.

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'login_count': loginCount,
    };
  }

  /// Constructs a [UserLoginModel] instance from a map.
  factory UserLoginModel.fromMap(Map<String, dynamic> map) {
    return UserLoginModel(
      email: map['email'],
      password: map['password'],
      loginCount: map['login_count'],
    );
  }


}