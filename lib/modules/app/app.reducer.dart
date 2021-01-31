import 'package:mobile/modules/app/app.model.dart';
import 'package:mobile/modules/auth/logic/auth.reducer.dart';
import 'package:mobile/modules/users/logic/users_item.reducer.dart';
import 'package:mobile/modules/users/logic/users_list.reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    auth: authReducer(state.auth, action),
    users: usersReducer(state.users, action),
    user: userReducer(state.user, action),
  );
}
