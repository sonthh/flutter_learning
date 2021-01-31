import 'package:flutter/material.dart';
import 'package:mobile/modules/users/screens/users_detail.screen.dart';
import 'package:mobile/modules/users/screens/users_list.screen.dart';

Route<Widget> onGenerateRoute(RouteSettings settings) {
  if (settings.name == UserListScreen.routeName) {
    return MaterialPageRoute(
      builder: (context) {
        return UserListScreen();
      },
    );
  }
  if (settings.name == UserDetailScreen.routeName) {
    final UserDetailScreenArgs args = settings.arguments;

    return MaterialPageRoute(
      builder: (context) {
        return UserDetailScreen(id: args.id);
      },
    );
  }
  return null;
}
