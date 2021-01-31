import 'dart:convert';

import 'package:mobile/modules/users/logic/users.action.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;

final Reducer<UserState> userReducer =
    combineReducers(<UserState Function(UserState, dynamic)>[
  TypedReducer<UserState, FindOneUserRequest>(findOneUserRequest),
  TypedReducer<UserState, FindOneUserSuccess>(findOneUserSuccess),
  TypedReducer<UserState, FindOneUserFailure>(findOneUserFailure),
]);

UserState findOneUserRequest(UserState state, FindOneUserRequest action) {
  return state.copyWith(isLoading: action.isLoading);
}

UserState findOneUserSuccess(UserState state, FindOneUserSuccess action) {
  return state.copyWith(isLoading: action.isLoading, user: action.user);
}

UserState findOneUserFailure(UserState state, FindOneUserFailure action) {
  return state.copyWith(isLoading: action.isLoading, error: action.error);
}

ThunkAction findOneUserAction(int id) {
  return (Store store) async {
    try {
      await store.dispatch(FindOneUserRequest(isLoading: true));

      final client = http.Client();
      final url = 'https://jsonplaceholder.typicode.com/users/$id';
      final response = await client.get(url);

      User user = User.fromJson(jsonDecode(response.body));

      await store.dispatch(FindOneUserSuccess(isLoading: false, user: user));
    } catch (e, stackTrace) {
      await store.dispatch(FindOneUserFailure(isLoading: false, error: true));
      print(e);
      print(stackTrace);
    }
  };
}
