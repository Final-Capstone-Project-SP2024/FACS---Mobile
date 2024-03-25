class UserModel {
  final String email;
  final String phone;
  final String name;
  final String password;
  final int userRole;

  UserModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.password,
    required this.userRole,
  });

  // Convert User object to a Map for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'name': name,
      'password': password,
      'userRole': userRole,
    };
  }
}
