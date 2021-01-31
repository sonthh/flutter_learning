import 'package:meta/meta.dart';

class User {
  final int id;
  final String username;
  final String email;

  User({
    this.id,
    this.username,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}

@immutable
class UsersState {
  final bool isLoading;
  final bool error;
  final List<User> users;

  UsersState({
    @required this.isLoading,
    @required this.error,
    @required this.users,
  });

  factory UsersState.initial() {
    return new UsersState(
      isLoading: false,
      error: false,
      users: [],
    );
  }

  UsersState copyWith({
    bool isLoading,
    bool error,
    List<User> users,
  }) {
    return new UsersState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'users': users,
    };
  }
}

@immutable
class UserState {
  final bool isLoading;
  final bool error;
  final User user;

  UserState({
    @required this.isLoading,
    @required this.error,
    @required this.user,
  });

  factory UserState.initial() {
    return new UserState(
      isLoading: false,
      error: false,
      user: null,
    );
  }

  UserState copyWith({
    bool isLoading,
    bool error,
    User user,
  }) {
    return new UserState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'user': user,
    };
  }
}
