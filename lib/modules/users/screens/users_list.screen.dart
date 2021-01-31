import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/modules/app/app.model.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:mobile/modules/users/logic/users_list.reducer.dart';
import 'package:mobile/modules/users/widgets/user_list.widget.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final List<User> users;
  final bool isLoading;

  final Function() findAll;

  ViewModel({
    this.users,
    this.isLoading,
    this.findAll,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      users: store?.state?.users?.users,
      isLoading: store?.state?.users?.isLoading,
      findAll: () {
        store.dispatch(findAllUsersAction());
      },
    );
  }
}

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      onInit: (Store<AppState> store) async {
        EasyLoading.show();
        ViewModel.fromStore(store).findAll();
      },
      converter: (Store<AppState> store) {
        return ViewModel.fromStore(store);
      },
      onWillChange: (ViewModel prevModel, ViewModel currentModel) {
        if (prevModel.isLoading == true && currentModel.isLoading == false) {
          EasyLoading.dismiss();
        }
      },
      builder: (BuildContext context, ViewModel viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text('User list'),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Late nights team'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Hong Son Tran'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Huy Le Hoang'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Phi Nguyen Hoang'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      EasyLoading.show();
                      viewModel.findAll();
                    },
                    child: UserListWidget(users: viewModel.users),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
