import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/modules/users/screens/users_detail.screen.dart';
import 'package:mobile/modules/users/states/users.model.dart';
// import 'package:mobile/modules/users/screens/users_detail.screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;
  final ScrollController controller;

  UserListWidget({@required this.users, @required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: users.length,
      itemBuilder: (context, index) {
        if (index == users.length) {
          return CupertinoActivityIndicator();
        }

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigoAccent,
                child: Text('${users[index]?.username[0]}'),
                foregroundColor: Colors.white,
              ),
              title: Text('${users[index]?.username}'),
              subtitle: Text('${users[index]?.email}'),
            ),
          ),
          actions: [
            IconSlideAction(
              caption: 'Archive',
              color: Colors.blue,
              icon: Icons.archive,
              // onTap: () => _showSnackBar('Archive'),
            ),
            IconSlideAction(
              caption: 'Share',
              color: Colors.indigo,
              icon: Icons.share,
              // onTap: () => _showSnackBar('Share'),
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Detail',
              color: Colors.green,
              icon: Icons.navigate_next,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  UserDetailScreen.routeName,
                  arguments: UserDetailScreenArgs(users[index].id),
                );
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => showMyDialog(context),
            ),
          ],
        );
      },
    );
  }
}

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Do you want to delete this user?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
