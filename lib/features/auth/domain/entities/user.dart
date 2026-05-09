class User {
  /// Unique identifier for the user
  final String id;

  /// User's email address
  final String email;

  /// User's display name
  final String username;

  /// Authentication token for API calls
  final String token;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.token,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          username == other.username &&
          token == other.token;

  @override
  int get hashCode => Object.hash(id, email, username, token);

  @override
  String toString() => 'User(id: $id, email: $email, username: $username)';
}
