import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prc_riverpod/counter.dart';
import 'package:prc_riverpod/todo/home_screen.dart';
import 'hello_world.dart';

void main() {
  runApp(ProviderScope(
    // child: MyApp(),
    // child: CounterDemo(),
    child: HomeScreen(),
  ));
}
