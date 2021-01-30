import 'package:mobile/modules/users/logic/users.model.dart';

/* user list result */
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
