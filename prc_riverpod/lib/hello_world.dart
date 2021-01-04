import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloworldProdiver = Provider((_) => 'Hello World');

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String value = watch(helloworldProdiver);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Practice Riverpod'),
        ),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}
