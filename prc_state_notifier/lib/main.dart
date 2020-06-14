import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:prc_state_notifier/todo_provider.dart';

import 'todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<TodoController, List<String>>(
      create: (context) => TodoController(),
      child: MaterialApp(
        title: 'Test Site',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: TodoPage(),
      ),
    );
  }
}
