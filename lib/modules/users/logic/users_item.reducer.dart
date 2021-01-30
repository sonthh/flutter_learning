import 'dart:convert';

import 'package:mobile/modules/users/logic/users.action.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;


final Reducer<UserState> userReducer =
    combineReducers(<UserState Function(UserState, dynamic)>[
  TypedReducer<UserState, SetLoading>(setLoading),
  TypedReducer<UserState, SetUser>(setUser),
]);

UserState setLoading(UserState state, SetLoading action) {
  state = state.copyWith(isLoading: action.isLoading);

  return state;
}

UserState setUser(UserState state, SetUser action) {
  state = state.copyWith(user: action.user);

  return state;
}

ThunkAction findOneUserAction(int id) {
  return (Store store) async {
    try {
      await store.dispatch(SetLoading(true));

      final client = http.Client();
      final url = 'https://jsonplaceholder.typicode.com/users/$id';
      final response = await client.get(url);

      User user = User.fromJson(jsonDecode(response.body));

      await store.dispatch(SetUser(user));
      await store.dispatch(SetLoading(false));
    } catch (e, stackTrace) {
      store.dispatch(SetLoading(false));
      print(e);
      print(stackTrace);
    }
  };
}