import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/task.dart';
import '../models/user.dart';
import '../utils/env.dart';

class ApiService extends GetxService {
  Future<bool> login(String user, String password) async {
    if (Get.testMode) {
      if (user == "test" && password == "test") {
        return true;
      } else {
        return false;
      }
    } else {
      bool result = false;
      var url = "${Env.URL_PREFIX}/login.php?username=$user&password=$password";
      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);

      if (data == "Success") {
        result = true;
      } else {
        result = false;
      }
      return result;
    }
  }

  Future<List<Task>> getTaskList() async {
    List<Task> tasks = <Task>[];
    if (Get.testMode) {
      tasks.add(Task(id: 1, name: 'Task 1', userId: 1));
      tasks.add(Task(id: 2, name: 'Task 2', userId: 2));
      tasks.add(Task(id: 3, name: 'Task 3', userId: 2));
      tasks.add(Task(id: 4, name: 'Task 4', userId: 1));
    } else {
      final response = await http.get(Uri.parse("${Env.URL_PREFIX}/list.php"));

      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      tasks = items.map<Task>((json) {
        return Task.fromJson(json);
      }).toList();
    }

    return tasks;
  }

  Future<List<User>> getUsers() async {
    List<User> users = <User>[];
    if (Get.testMode) {
      users.add(User(id: 1, username: 'User aaa'));
      users.add(User(id: 2, username: 'User bbb'));
      users.add(User(id: 3, username: 'User ccc'));
      users.add(User(id: 4, username: 'User ddd'));
    } else {
      final response = await http.get(Uri.parse("${Env.URL_PREFIX}/users.php"));
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      users = items.map<User>((json) {
        return User.fromJson(json);
      }).toList();
    }

    return users;
  }

  Future<bool> createTask(String text, int affectedUser) async {
    if (Get.testMode) {
      return true;
    } else {
      var response = await http.get(Uri.parse("${Env.URL_PREFIX}/create.php?name=$text&user_id=$affectedUser"));
      var data = json.decode(response.body);

      if (data == "Success") {
        return true;
      } else {
        return false;
      }
    }
  }
}
