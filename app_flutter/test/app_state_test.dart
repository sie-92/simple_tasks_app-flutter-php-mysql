// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:myapp/models/task.dart';
import 'package:myapp/service/api_service.dart';
import 'package:myapp/state/app_state.dart';

import 'test_helper.dart';

init() async {
  FlutterError.onError = ignoreOverflowErrors;
  Get.testMode = true;
  //Get.put(AppState());
  Get.put(ApiService());
}

Widget withMaterialApp({required Widget child}) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('test login success', (WidgetTester tester) async {
    await init();
    var state = AppState();
    bool result = await state.login("test", "test");
    expect(result, true);
  });

  testWidgets('test login error', (WidgetTester tester) async {
    await init();
    var state = AppState();
    bool result = await state.login("aaa", "aaa");
    expect(result, false);
  });

  testWidgets('test get task list', (WidgetTester tester) async {
    await init();
    var state = AppState();
    List<Task> result = await state.getTaskList();
    expect(result.isNotEmpty, true);
  });

  testWidgets('test get users', (WidgetTester tester) async {
    await init();
    var state = AppState();
    await state.getUsers();
    expect(state.users.isNotEmpty, true);
  });

  testWidgets('test create task', (WidgetTester tester) async {
    await init();
    var state = AppState();
    bool result = await state.createTask("test", 2);
    expect(result, true);
  });
}
