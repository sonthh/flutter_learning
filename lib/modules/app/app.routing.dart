import 'package:flutter/material.dart';
import 'package:mobile/modules/users/screens/users_detail.screen.dart';
import 'package:mobile/modules/users/screens/users_list.screen.dart';

Route<Widget> onGenerateRoute(RouteSettings settings) {
  if (settings.name == 'users.list') {
    return MaterialPageRoute(
      builder: (context) {
        return UserListScreen();
      },
    );
  }
  if (settings.name == 'users.detail') {
    final UserDetailScreenArgs args = settings.arguments;

    return MaterialPageRoute(
      builder: (context) {
        return UserDetailScreen(id: args.id);
      },
    );
  }
  return null;
}
