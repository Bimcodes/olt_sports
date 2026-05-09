/// Data model representing user data from the API
///
/// This model:
/// 1. Handles JSON serialization/deserialization
/// 2. Maps to/from the domain [User] entity
///
/// Separation from Entity:
/// - [UserModel] knows about JSON and API structure
/// - [User] entity is pure business logic, no serialization
library;

import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  final String token;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.token,
  });

  // Creates a UserModel from JSON i.e creating a user model from the api response by mapping the
  // response to my user model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      token: json['access_token'] as String,
    );
  }

  /// Converts this model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'access_token': token,
    };
  }

  /// Converts this model to a domain [User] entity
  User toEntity() {
    return User(id: id, email: email, username: username, token: token);
  }

  /// Creates a UserModel from a domain [User] entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      username: user.username,
      token: user.token,
    );
  }
}
