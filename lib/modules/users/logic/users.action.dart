import 'package:mobile/modules/users/logic/users.model.dart';

/* user list result */
class FindAllUserRequest {
  FindAllUserRequest({this.isLoading});

  final bool isLoading;
}

class FindAllUserSuccess {
  FindAllUserSuccess({this.isLoading, this.users});

  final bool isLoading;
  final List<User> users;
}

class FindAllUserFailure {
  FindAllUserFailure({this.isLoading, this.error});

  final bool isLoading;
  final bool error;
}

/* user single result */
class FindOneUserRequest {
  FindOneUserRequest({this.isLoading});

  final bool isLoading;
}

class FindOneUserSuccess {
  FindOneUserSuccess({this.isLoading, this.user});

  final bool isLoading;
  final User user;
}

class FindOneUserFailure {
  FindOneUserFailure({this.isLoading, this.error});

  final bool isLoading;
  final bool error;
}