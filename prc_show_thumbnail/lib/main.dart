
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
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

class MyHomePage extends StatelessWidget {

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('web image'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.red,
            child: InkWell(
              onTap: () => _launchURL('https://youtu.be/BKejYr9Wcgc'),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://i.ytimg.com/vi/BKejYr9Wcgc/mqdefault.jpg'
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child: InkWell(
              onTap: () => _launchURL('https://www.instagram.com/p/IljFIig5dP/'),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'http://instagr.am/p/IljFIig5dP/media?size=t'
              ),
            ),
          )
        ],
      ),
    );
  }
}