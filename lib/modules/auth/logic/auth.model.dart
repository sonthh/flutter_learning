import 'package:meta/meta.dart';

@immutable
class AuthState {
  final bool isLoading;
  final bool error;
  final String user;

  AuthState({
    @required this.isLoading,
    @required this.error,
    @required this.user,
  });

  factory AuthState.initial() {
    return new AuthState(
      isLoading: false,
      error: false,
      user: null,
    );
  }

  AuthState copyWith({
    bool isLoading,
    bool error,
    String user,
  }) {
    return new AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          error == other.error &&
          user == other.user;

  @override
  int get hashCode => isLoading.hashCode ^ user.hashCode;

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'error': error,
        'user': user,
      };
}
