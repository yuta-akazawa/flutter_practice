import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((ref) => 0);

class CounterDemo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final int count = watch(counterProvider).state;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: Center(
          child: Text('${count.toString()}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // ignore: unnecessary_statements
            context.read(counterProvider).state++;
          },
        ),
      ),
    );
  }
}
