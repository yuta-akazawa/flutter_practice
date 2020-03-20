import 'package:flutter/material.dart';
import 'package:prc_preview_link/fetch_preview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}


class MyHomePageState extends State<MyHomePage> {

  String url;
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Preview'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  url = value;
                });
              },
            ),
          ),
          RaisedButton(
              onPressed:() {
                FetchPreview().fetch(url).then((data) {
                  setState(() {
                    this.data = data;
                  });
                });
              },
            child: Text('Fetch'),
          ),
          _previewWidget(),
        ],
      ),
    );
  }

  _previewWidget() {
    if (data == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.green[100],
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(data['image'], height: 100, width: 100,fit: BoxFit.cover,),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data['title'], style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 4,),
                    Text(data['description']),
                    SizedBox(height: 4,),
                    Text(url, style: TextStyle(color: Colors.grey, fontSize: 12),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}