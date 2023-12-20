import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/service/api_service.dart';
import 'package:myapp/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: (Get.find<AppState>()).isLoggedIn ? HomeScreen() : LoginScreen(),
  ));
}

initApp() async {
  Get.put(ApiService());

  var prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null) ? false : prefs.getBool('isLoggedIn');

  Get.put(AppState()..isLoggedIn = isLoggedIn!);
}
