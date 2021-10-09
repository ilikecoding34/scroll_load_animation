import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider_test/TaskApiModel.dart';
import 'package:http/http.dart' as http;

class TodoModel extends ChangeNotifier {
  // List<TaskModel> taskList = [];
  List<TaskApiModel> taskapiList = []; //contians all the task
  bool stop = false;
  bool loaded = true;

  get getloaded => loaded;

  addTaskInList() {
    TaskApiModel taskModel = TaskApiModel(1, 1, 'title', true);
    taskapiList.add(taskModel);

    notifyListeners();
    //code to do
  }

  getalldatas(int szam, int limit) async {
    String lekeres = szam.toString();
    String slimit = limit.toString();

    loaded = false;
    notifyListeners();
    var client = http.Client();

    try {
      var uriResponse = await client.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/todos?_start=$lekeres&_limit=$slimit'));

      var responseData = json.decode(uriResponse.body);
      for (var singleUser in responseData) {
        TaskApiModel task = TaskApiModel(singleUser['userId'], singleUser['id'],
            singleUser['title'], singleUser['completed']);

        //Adding user to the list.
        taskapiList.add(task);
      }
      Future.delayed(Duration(seconds: 1), () {
        loaded = true;
        notifyListeners();
      });
    } finally {
      client.close();
    }
  }
/*
  getserverdata() async {
    var client = http.Client();
    try {
      var uriResponse = await client
          .get(Uri.parse('http://188.166.98.87:1880/status/Heater'));
      print(uriResponse.body);
      notifyListeners();
    } finally {
      client.close();
    }
  }*/
}
