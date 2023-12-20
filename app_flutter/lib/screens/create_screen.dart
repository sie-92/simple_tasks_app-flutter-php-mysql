import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myapp/utils/test_keys.dart';

import '../models/user.dart';
import '../state/app_state.dart';
import '../utils/env.dart';

class CreateScreen extends StatefulWidget {
  final Function refreshTaskList;
  late final AppState appState;

  CreateScreen({
    Key? key,
    required this.refreshTaskList,
    AppState? state,
  }) : super(key: key) {
    appState = state ?? Get.find<AppState>();
  }

  @override
  CreateScreenState createState() => CreateScreenState();
}

class CreateScreenState extends State<CreateScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  int? affectedUser;

  void _onConfirm(context) async {
    await widget.appState.getTaskList();
    bool result = await widget.appState.createTask(nameController.text, affectedUser!);
    if (result) {
      Fluttertoast.showToast(
          msg: "task created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "error creating task",
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
        appBar: AppBar(
          title: const Text("New Task"),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.all(Env.sizeUnit * 3),
            child: ElevatedButton(
              key: TestKeys.createButton,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () {
                if (nameController.text.isNotEmpty && affectedUser != null) {
                  _onConfirm(context);
                } else {
                  Fluttertoast.showToast(
                      msg: "please input a task name and affect a user",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text("CONFIRM"),
            )),
        body: Container(
          alignment: Alignment.center,
          key: TestKeys.createScreen,
          child: SizedBox(
            height: Env.sizeUnit * 40,
            width: Env.sizeUnit * 40,
            child: Card(
              elevation: 3,
              margin: EdgeInsets.all(Env.sizeUnit * 1.5),
              color: Colors.amberAccent,
              child: Form(
                key: TestKeys.createForm,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(Env.sizeUnit * 2),
                        child: SizedBox(
                            width: Env.sizeUnit * 25,
                            child: TextFormField(
                              key: TestKeys.createName,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(labelText: 'Name'),
                            ))),
                    Padding(
                        padding: EdgeInsets.all(Env.sizeUnit),
                        child: SizedBox(
                            width: Env.sizeUnit * 25,
                            height: Env.sizeUnit * 5,
                            child: DropdownButton(
                              hint: const Text('Please affect a user'),
                              value: affectedUser,
                              key: TestKeys.createUser,
                              alignment: Alignment.center,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: widget.appState.users.map((User item) {
                                return DropdownMenuItem(
                                  value: item.id,
                                  child: Text(item.username),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  affectedUser = value!;
                                });
                              },
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
