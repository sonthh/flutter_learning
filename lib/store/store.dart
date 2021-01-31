import 'package:mobile/modules/auth/logic/auth.model.dart';
import 'package:mobile/modules/auth/logic/auth.reducer.dart';
import 'package:mobile/modules/users/logic/users_item.reducer.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:mobile/modules/users/logic/users_list.reducer.dart';
import 'package:meta/meta.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    auth: authReducer(state.auth, action),
    users: usersReducer(state.users, action),
    user: userReducer(state.user, action),
  );
}

@immutable
class AppState {
  final AuthState auth;
  final UsersState users;
  final UserState user;

  AppState({
    @required this.auth,
    @required this.users,
    @required this.user,
  });

  factory AppState.initial() {
    return AppState(
      auth: AuthState.initial(),
      users: UsersState.initial(),
      user: UserState.initial(),
    );
  }

  AppState copyWith({
    AuthState auth,
    UsersState users,
    UsersState user,
  }) {
    return AppState(
      auth: auth ?? this.auth,
      users: users ?? this.users,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth': auth,
      'users': users,
      'user': user,
    };
  }
}
