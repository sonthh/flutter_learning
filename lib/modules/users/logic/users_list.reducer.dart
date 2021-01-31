import 'dart:convert';

import 'package:mobile/modules/configs/configs.dart';
import 'package:mobile/modules/users/logic/users.action.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;

final config = ConfigService();

final Reducer<UsersState> usersReducer =
    combineReducers(<UsersState Function(UsersState, dynamic)>[
  TypedReducer<UsersState, FindAllUserRequest>(findAllUserRequest),
  TypedReducer<UsersState, FindAllUserSuccess>(findAllUserSuccess),
  TypedReducer<UsersState, FindAllUserFailure>(findAllUserFailure),
]);

UsersState findAllUserRequest(UsersState state, FindAllUserRequest action) {
  return state.copyWith(isLoading: action.isLoading);
}

UsersState findAllUserSuccess(UsersState state, FindAllUserSuccess action) {
  return state.copyWith(isLoading: action.isLoading, users: action.users);
}

UsersState findAllUserFailure(UsersState state, FindAllUserFailure action) {
  return state.copyWith(isLoading: action.isLoading, error: action.error);
}

ThunkAction findAllUsersAction() {
  return (Store store) async {
    try {
      await store.dispatch(FindAllUserRequest(isLoading: true));

      final client = http.Client();
      final url = '${config.apiUrl}/users';
      final response = await client.get(url);

      final Iterable json = jsonDecode(response.body);
      List<User> users = List.from(json.map((model) => User.fromJson(model)));

      await store.dispatch(FindAllUserSuccess(isLoading: false, users: users));
    } catch (e, stackTrace) {
      await store.dispatch(FindAllUserFailure(isLoading: false, error: true));
      print(e);
      print(stackTrace);
    }
  };
}
