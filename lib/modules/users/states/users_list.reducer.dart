
import 'package:mobile/modules/users/states/users.action.dart';
import 'package:mobile/modules/users/states/users.model.dart';
import 'package:mobile/modules/users/services/users.services.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final usersService = UsersService();

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
  final users = state.users;
  users.addAll(action.users);
  return state.copyWith(isLoading: action.isLoading, users: users);
}

UsersState findAllUserFailure(UsersState state, FindAllUserFailure action) {
  return state.copyWith(isLoading: action.isLoading, error: action.error);
}

ThunkAction findAllUsersAction() {
  return (Store store) async {
    try {
      await store.dispatch(FindAllUserRequest(isLoading: true));
      List<User> users = await usersService.findAll();
      await store.dispatch(FindAllUserSuccess(isLoading: false, users: users));
    } catch (e) {
      await store.dispatch(FindAllUserFailure(isLoading: false, error: true));
      print(e);
    }
  };
}
