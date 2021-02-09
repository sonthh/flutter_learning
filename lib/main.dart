import 'package:firebase_messaging/firebase_messaging.dart';
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

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }

  // Or do other work.
}

void main() async {
  await ConfigService.load();
  final config = ConfigService();

  print('My app is run at ${config.mode} mode');
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

class MyApp extends StatefulWidget {
  static final routeName = 'users.list';
  final Store<AppState> store;

  MyApp({@required this.store});

  @override
  MyAppState createState() => MyAppState(store: store);
}

class MyAppState extends State<MyApp> {
  final Store<AppState> store;

  MyAppState({@required this.store});

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );
  
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print('get devices token');
      print("Push Messaging token: $token");
    });

    _firebaseMessaging.subscribeToTopic("matchscore");

  }
}
