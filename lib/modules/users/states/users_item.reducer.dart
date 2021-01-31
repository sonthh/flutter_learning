
import 'package:mobile/modules/users/states/users.action.dart';
import 'package:mobile/modules/users/states/users.model.dart';
import 'package:mobile/modules/users/services/users.services.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final usersService = UsersService();

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

      User user = await usersService.findOne(id);

      await store.dispatch(FindOneUserSuccess(isLoading: false, user: user));
    } catch (e) {
      await store.dispatch(FindOneUserFailure(isLoading: false, error: true));
      print(e);
    }
  };
}
