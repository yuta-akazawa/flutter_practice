import 'package:flutter/material.dart';
import 'package:prc_overlay_widget/zoom_overlay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Overlay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: MyHomePage(),
      home: EntireViewScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        child: Positioned(
          top: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          child: CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: const Text('1'),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overlay Example"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            showOverlay(context);
          },
          child: Text(
            "Show My Icon",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
        ),
      ),
    );
  }
}
