import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/modules/auth/screens/login.screen.dart';
import 'package:mobile/modules/users/screens/users_detail.screen.dart';
import 'package:mobile/modules/users/screens/users_list.screen.dart';
import 'package:mobile/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

void main() async {
  final remoteDevtools = RemoteDevToolsMiddleware('192.168.31.206:8000');
  await remoteDevtools.connect();
  final store = new DevToolsStore<AppState>(
    appReducer,
    initialState: new AppState.initial(),
    middleware: [
      thunkMiddleware,
      remoteDevtools,
    ],
  );

  runApp(MyApp(store: store));
}

class Keys {
  static final navKey = new GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        theme: ThemeData(primarySwatch: Colors.green),
        navigatorKey: Keys.navKey,
        home: LoginScreen(),
        onGenerateRoute: (settings) {
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
        },
      ),
    );
  }
}
