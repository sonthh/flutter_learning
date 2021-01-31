import 'package:mobile/modules/app/app.model.dart';
import 'package:mobile/modules/auth/states/auth.reducer.dart';
import 'package:mobile/modules/users/states/users_item.reducer.dart';
import 'package:mobile/modules/users/states/users_list.reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    auth: authReducer(state.auth, action),
    users: usersReducer(state.users, action),
    user: userReducer(state.user, action),
  );
}
