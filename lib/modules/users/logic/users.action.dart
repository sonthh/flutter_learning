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

class SetLoading {
  SetLoading(this.isLoading);

  final bool isLoading;
}

class SetUsers {
  SetUsers(this.users);

  final List<User> users;
}

/* user single result */
class SetUser {
  SetUser(this.user);

  final User user;
}
