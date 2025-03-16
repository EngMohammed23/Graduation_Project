class UserProfile {
  final String userId;
  final String name;
  final String email;
  final String phone;

  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      userId: data['userId'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
    );
  }
}
