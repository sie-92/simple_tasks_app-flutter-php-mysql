import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/create_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/utils/test_keys.dart';

import '../models/task.dart';
import '../state/app_state.dart';
import '../utils/env.dart';

class HomeScreen extends StatefulWidget {
  late final AppState appState;
  HomeScreen({
    Key? key,
    AppState? state,
  }) : super(key: key) {
    appState = state ?? Get.find<AppState>();
  }

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<Task>> tasks;
  final studentListKey = GlobalKey<HomeScreenState>();

  @override
  void initState() {
    super.initState();
    widget.appState.getUsers();
    tasks = widget.appState.getTaskList();
  }

  void refreshTaskList() {
    setState(() {
      tasks = widget.appState.getTaskList();
    });
  }

  get navigateToLoginScreen => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(state: widget.appState),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: TestKeys.homeScreen,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Task List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              refreshTaskList();
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Task>>(
          future: tasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  color: Colors.amberAccent,
                  child: ListTile(
                    leading: const Icon(Icons.task),
                    title: Text(
                      data.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      widget.appState.users.firstWhereOrNull((element) => element.id == data.userId) == null
                          ? "none"
                          : widget.appState.users.firstWhereOrNull((element) => element.id == data.userId)!.username,
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: () {},
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Env.sizeUnit * 3),
          child: ElevatedButton(
            key: TestKeys.createButton,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
            onPressed: () {
              widget.appState.logout();
              Navigator.pop(context);
              navigateToLoginScreen;
            },
            child: const Text("LOGOUT"),
          )),
      floatingActionButton: FloatingActionButton(
        key: TestKeys.createTask,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CreateScreen(
              refreshTaskList: refreshTaskList,
            );
          }));
        },
      ),
    );
  }
}
