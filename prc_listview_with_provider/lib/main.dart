import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prc_listview_with_provider/photo_data.dart';
import 'package:http/http.dart' as http;
import 'package:prc_listview_with_provider/scroll_event.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  Future<List<PhotoData>> getPhotos() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/photos");
    List<dynamic> raw = jsonDecode(data.body);
    return raw.map((f) => PhotoData.fromJson(f));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Awesome Listview"),
        elevation: 0,
      ),
      body: Container(
        color: Colors.deepOrange,
        child: ChangeNotifierProvider.value(
          value: ScrollEvent(false),
          child: Builder(
            builder: (context) {
              final scrollEvent = Provider.of<ScrollEvent>(context);
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    scrollEvent.isScrolling = true;
                    debugPrint("scroll start");
                  } else if (notification is ScrollEndNotification) {
                    scrollEvent.isScrolling = false;
                    debugPrint("scroll end");
                  }
                  return true;
                },
                child: ListView.builder(
                    itemCount: PhotoData.json.length,
                    itemBuilder: (context, index) {
                      return CustomListTile(PhotoData.fromJson(PhotoData.json[index]));
                    }
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final PhotoData data;
  CustomListTile(this.data);

  @override
  Widget build(BuildContext context) {

    final isScrolling = Provider.of<ScrollEvent>(context).isScrolling;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 200),
        tween: Tween(
          begin: isScrolling ? 0.0 : -0.2,
          end: isScrolling ? -0.2 : 0.0,
        ),
        builder: (_, double rotation, _child) {
          return Transform(
            transform: Matrix4.identity()..setEntry(3, 2, 0.01) ..rotateX(isScrolling ? -0.2 : 0.0),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2.0,
                      blurRadius: 6.0,
                      color: Colors.black.withOpacity(0.1),
                    )
                  ]
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: Container(
                  color: RandomColorGenerator.getcolor(),
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(data.thumbnailUrl),
                  ),
                ),
                title: Text(data.title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${data.id} Album"),
                    Text("Provided by JSON Placeholder")
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RandomColorGenerator {
  static Random random = Random();
  static Color getcolor() {
    return Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}