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
import 'package:myapp/screens/create_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/service/api_service.dart';
import 'package:myapp/state/app_state.dart';
import 'package:myapp/utils/test_keys.dart';

import 'test_helper.dart';

init() async {
  FlutterError.onError = ignoreOverflowErrors;
  Get.testMode = true;
  Get.put(AppState());
  Get.put(ApiService());
}

Widget withMaterialApp({required Widget child}) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('test show home screen', (WidgetTester tester) async {
    await init();
    await tester.pumpWidget(withMaterialApp(child: HomeScreen()));
    expect(find.byKey(TestKeys.homeScreen), findsOneWidget);
  });

  testWidgets('test show login screen', (WidgetTester tester) async {
    await init();
    await tester.pumpWidget(withMaterialApp(child: LoginScreen()));
    expect(find.byKey(TestKeys.loginScreen), findsOneWidget);
    expect(find.byKey(TestKeys.loginUsername), findsOneWidget);
    expect(find.byKey(TestKeys.loginPassword), findsOneWidget);
    expect(find.byKey(TestKeys.loginButton), findsOneWidget);
  });

  testWidgets('test show create screen', (WidgetTester tester) async {
    await init();
    await tester.pumpWidget(withMaterialApp(child: CreateScreen(refreshTaskList: () {})));
    expect(find.byKey(TestKeys.createScreen), findsOneWidget);
    expect(find.byKey(TestKeys.createForm), findsOneWidget);
    expect(find.byKey(TestKeys.createName), findsOneWidget);
    expect(find.byKey(TestKeys.createUser), findsOneWidget);
    expect(find.byKey(TestKeys.createButton), findsOneWidget);
  });

  testWidgets('test tap create task on home screen and show create screen', (WidgetTester tester) async {
    await init();
    await tester.pumpWidget(withMaterialApp(child: HomeScreen()));
    expect(find.byKey(TestKeys.homeScreen), findsOneWidget);

    await tester.tap(find.byKey(TestKeys.createTask));
    await tester.pumpAndSettle();

    expect(find.byKey(TestKeys.homeScreen), findsNothing);
    expect(find.byKey(TestKeys.createScreen), findsOneWidget);
  });
}
