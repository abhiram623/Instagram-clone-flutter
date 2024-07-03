import 'dart:convert';

class UserModel {
  final String profilePic;
  final String email;
  final String password;
  final String name;
  final String bio;
  final String uid;
  final List<String> followers;
  final List<String> following;

  UserModel({
    required this.profilePic,
    required this.email,
    required this.password,
    required this.name,
    required this.bio,
    required this.uid,
    required this.followers,
    required this.following,
  });

  // Convert a UserModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'profilePic': profilePic,
      'email': email,
      'password': password,
      'name': name,
      'bio': bio,
      'uid': uid,
      'followers': followers,
      'following': following,
    };
  }

  // Create a UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profilePic: map['profilePic'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      uid: map['uid'] ?? '',
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
    );
  }

  // Convert a UserModel into a JSON string
  String toJson() => json.encode(toMap());

  // Create a UserModel from a JSON string
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}