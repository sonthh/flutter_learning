import 'package:mobile/modules/auth/logic/auth.model.dart';
import 'package:mobile/modules/auth/logic/auth.reducer.dart';
import 'package:mobile/modules/users/logic/user.reducer.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:mobile/modules/users/logic/users.reducer.dart';
// import 'package:redux/redux.dart';
import 'package:meta/meta.dart';

// final store = Store<AppState>(
//   appReducer,
//   initialState: new AppState.initial(),
//   middleware: [thunkMiddleware],
// );
// final remoteDevtools = RemoteDevToolsMiddleware('192.168.31.206:8000');

// final store = new DevToolsStore<AppState>(
//   appReducer,
//   initialState: new AppState.initial(),
//   middleware: [
//     thunkMiddleware,
//     remoteDevtools,
//   ],
// );

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

  @override
  int get hashCode =>
      //isLoading.hash Code ^
      auth.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppState && auth == other.auth;

  Map<String, dynamic> toJson() => {
        'auth': auth,
        'users': users,
        'user': user,
      };
}
