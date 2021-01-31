import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobile/modules/app/app.model.dart';
import 'package:mobile/modules/auth/states/auth.reducer.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final bool isLoading;
  final bool error;
  final String user;

  final Function(String username, String password) login;

  ViewModel({
    this.isLoading,
    this.error,
    this.user,
    this.login,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      isLoading: store?.state?.auth?.isLoading,
      error: store?.state?.auth?.error,
      user: store?.state?.auth?.user,
      login: (String username, String password) {
        store.dispatch(usernamePasswordLogin(username, password));
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final formController = TextEditingController(text: '123456');

  @override
  void initState() {
    super.initState();

    formController.addListener(
      () => {
        // print('Password Change ${formController.text}'),
      },
    );
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      onInit: (Store<AppState> store) async {},
      converter: (Store<AppState> store) {
        return ViewModel.fromStore(store);
      },
      builder: (BuildContext context, ViewModel viewModel) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                  ),
                  initialValue: 'son',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    // print("Username change: $text");
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  controller: formController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        // print(formController.text);
                        viewModel.login('son', '123456');
                      }
                    },
                    child: Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
