import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/modules/app/app.model.dart';
import 'package:mobile/modules/app/app.reducer.dart';
import 'package:mobile/modules/app/app.routing.dart';
import 'package:mobile/modules/auth/screens/login.screen.dart';
import 'package:mobile/modules/configs/configs.service.dart';
import 'package:redux/redux.dart';
import 'package:redux_remote_devtools/redux_remote_devtools.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

void main() async {
  await ConfigService.load();
  final config = ConfigService();

  // REDUX DEVTOOLS
  if (config.mode == 'DEBUG') {
    final remoteDevtools = RemoteDevToolsMiddleware(config.reduxDevtoolsUrl);
    await remoteDevtools.connect();

    final store = new DevToolsStore<AppState>(
      appReducer,
      initialState: new AppState.initial(),
      middleware: [
        thunkMiddleware,
        remoteDevtools,
      ],
    );
    remoteDevtools.store = store;
    runApp(MyApp(store: store));
    return;
  }

  // WITHOUT REDUX DEVTOOLS
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.initial(),
    middleware: [
      thunkMiddleware,
    ],
  );
  runApp(MyApp(store: store));
}

class Keys {
  static final navKey = new GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({@required this.store});

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
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
