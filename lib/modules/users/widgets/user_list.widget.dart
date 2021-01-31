import 'package:flutter/material.dart';
import 'package:mobile/modules/users/states/users.model.dart';
import 'package:mobile/modules/users/screens/users_detail.screen.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;

  UserListWidget({@required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            users[index]?.username,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              'users.detail',
              arguments: UserDetailScreenArgs(users[index].id),
            );
          },
        );
      },
    );
  }
}
