import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myapp/utils/test_keys.dart';

import '../state/app_state.dart';
import '../utils/env.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  late final AppState appState;
  LoginScreen({
    Key? key,
    AppState? state,
  }) : super(key: key) {
    appState = state ?? Get.find<AppState>();
  }

  @override
  LoginScreenState createState() => LoginScreenState();

  navigateToMainScreen() {}
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  get navigateToMainScreen => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(state: widget.appState),
        ),
      );

  Future login() async {
    bool result = await widget.appState.login(user.text, pass.text);
    if (result) {
      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      navigateToMainScreen;
    } else {
      Fluttertoast.showToast(
          msg: "Login Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: TestKeys.loginScreen,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SizedBox(
          height: 300,
          child: Card(
            elevation: 3,
            margin: EdgeInsets.all(Env.sizeUnit * 1.5),
            color: Colors.white70,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Env.sizeUnit),
                  child: const Text(
                    'Connexion',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Env.sizeUnit),
                  child: TextField(
                    key: TestKeys.loginUsername,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: user,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Env.sizeUnit),
                  child: TextField(
                    obscureText: true,
                    key: TestKeys.loginPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    controller: pass,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Env.sizeUnit),
                  child: SizedBox(
                    width: 300,
                    child: MaterialButton(
                      key: TestKeys.loginButton,
                      clipBehavior: Clip.hardEdge,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      color: Colors.blueAccent,
                      child: const Text('Login',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      onPressed: () {
                        login();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
