import 'package:get/get.dart';
import 'package:myapp/models/task.dart';
import 'package:myapp/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AppState extends GetxController {
  bool isLoggedIn = false;
  List<Task> tasks = <Task>[];
  List<User> users = <User>[];

  Future<bool> login(String user, String password) async {
    bool result = false;
    ApiService api = Get.find();
    result = await api.login(user, password);

    if (!Get.testMode) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', result);
    }
    isLoggedIn = result;
    return result;
  }

  Future<List<Task>> getTaskList() async {
    ApiService api = Get.find();
    var list = await api.getTaskList();
    tasks.assignAll(list);
    return list;
  }

  Future<void> getUsers() async {
    ApiService api = Get.find();
    var list = await api.getUsers();
    users.assignAll(list);
  }

  Future<bool> createTask(String text, int affectedUser) async {
    ApiService api = Get.find();
    return await api.createTask(text, affectedUser);
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    isLoggedIn = false;
  }
}
