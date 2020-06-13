import 'package:flutter/material.dart';
import 'package:prc_state_notifier/todo_provider.dart';
import 'package:provider/provider.dart';

import 'todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
      ],
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
