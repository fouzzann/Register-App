class User {
  final int id;
  final String name;
  final String email;
  final String profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'No Name',
      email: json['email'] ?? 'No Email',
      profileImage: json['profile_image'] ?? '',
    );
  }
}
