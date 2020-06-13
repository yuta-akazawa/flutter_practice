
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoProvider with ChangeNotifier {
  List<String> todos = [];

  TodoProvider() {
    load();
  }

  add(String todo) {
    todos.add(todo);
    save();
  }

  remove(int index) {
    if (index >= 0 && index < todos.length) {
      todos.removeAt(index);
      save();
    }
  }

  load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todos = prefs.getStringList('todos');
    if (todos == null) todos = [];
    notifyListeners();
  }

  save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todos', todos);
    notifyListeners();
  }


}