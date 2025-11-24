import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  //reference for the box created in main.dart
  final _myBox = Hive.box("mybox");

  //to do list
  List toDoList = [];

  // run this method if this is the 1st time ever opening this app

  void createInitialData() {
    toDoList = [
      ["Lets Do Something", false],
      ["Lets Make another App", false],
    ];
  }

  //loading data from the database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the DataBase
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
