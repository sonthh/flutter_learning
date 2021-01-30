import 'package:mobile/main.dart';
import 'package:mobile/modules/auth/logic/auth.action.dart';
import 'package:mobile/modules/auth/logic/auth.model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;

final Reducer<AuthState> authReducer =
    combineReducers(<AuthState Function(AuthState, dynamic)>[
  TypedReducer<AuthState, SetLoading>(setLoading),
]);

AuthState setLoading(AuthState state, SetLoading action) {
  state = state.copyWith(isLoading: action.isLoading);

  return state;
}

ThunkAction usernamePasswordLogin(String username, String password) {
  return (Store store) async {
    try {
      await store.dispatch(SetLoading(true));
      await store.dispatch(SetLoading(false));
      Keys.navKey.currentState.pushNamed('users.list');
    } catch (e, stackTrace) {
      store.dispatch(SetLoading(false));
      print(e);
    }
  };
}
