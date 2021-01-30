import 'dart:convert';

import 'package:mobile/modules/users/logic/users.action.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;

final Reducer<UsersState> usersReducer =
    combineReducers(<UsersState Function(UsersState, dynamic)>[
  TypedReducer<UsersState, SetLoading>(setLoading),
  TypedReducer<UsersState, SetUsers>(setUsers),
]);

UsersState setLoading(UsersState state, SetLoading action) {
  state = state.copyWith(isLoading: action.isLoading);

  return state;
}

UsersState setUsers(UsersState state, SetUsers action) {
  state = state.copyWith(users: action.users);

  return state;
}

ThunkAction findAllUsersAction() {
  return (Store store) async {
    try {
      await store.dispatch(SetLoading(true));

      final client = http.Client();
      final url = 'https://jsonplaceholder.typicode.com/users';
      final response = await client.get(url);

      final Iterable json = jsonDecode(response.body);
      List<User> users = List.from(json.map((model) => User.fromJson(model)));

      await store.dispatch(SetUsers(users));
      await store.dispatch(SetLoading(false));
    } catch (e, stackTrace) {
      store.dispatch(SetLoading(false));
      print(e);
      print(stackTrace);
    }
  };
}
