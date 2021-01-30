import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/modules/users/logic/users_item.reducer.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:mobile/store/store.dart';
import 'package:redux/redux.dart';

class UserDetailScreenArgs {
  final int id;

  UserDetailScreenArgs(this.id);
}

class ViewModel {
  final User user;
  final bool isLoading;

  final Function(int id) findOne;

  ViewModel({
    this.user,
    this.isLoading,
    this.findOne,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      user: store?.state?.user?.user,
      isLoading: store?.state?.user?.isLoading,
      findOne: (int id) {
        store.dispatch(findOneUserAction(id));
      },
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  final int id;

  UserDetailScreen({@required this.id});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      onInit: (Store<AppState> store) async {
        EasyLoading.show(status: 'loading...');
        ViewModel.fromStore(store).findOne(id);
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
            title: Text(
              viewModel.user?.username ?? '',
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              viewModel.user?.email ?? '',
              style: TextStyle(fontSize: 25, color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
