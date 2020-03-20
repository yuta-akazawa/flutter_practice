import 'package:flutter/material.dart';
import 'package:prc_hero/pages/plane_ticket_list_page.dart';
import 'package:prc_hero/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: PlaneTicketListPage(),
    );
  }
}
