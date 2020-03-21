import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prc_preview_link/fetch_preview.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  url = FetchPreview().validateUrl(value);
                  print(url);
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

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _previewWidget() {
    if (data == null) {
      return Container();
    }

    return InkWell(
      onTap: () {
        _launchUrl(url);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.green[100],
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: data['image'],
                  imageBuilder: (context, imageProvider) => Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
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
      ),
    );
  }
}