
import 'package:flutter/material.dart';
import 'package:prc_hero/common/app_bar.dart';
import 'package:prc_hero/common/ticket_card.dart';
import 'package:prc_hero/common/toggle_widget.dart';
import 'package:prc_hero/model/ticket.dart';

class PlaneTicketListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Ticket ticket = Ticket();
    ticket.id = "1";
    ticket.sourceStation = "LHR";
    ticket.sourceCity = "London";
    ticket.departureTime = "15:00";
    ticket.destinationStation = "SXF";
    ticket.destinationCity = "New York";
    ticket.arrivalTime = "07:00";
    ticket.terminal = "12";
    ticket.game = "F62";
    ticket.boardingTime = "14:30";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Plane Ticket'),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            ToggleWidget(firstOption: "Not Used", secondOption: "Already Used"),
            SizedBox(height: 20.0),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                Hero(tag: ticket.id, child: TicketCardWidget(ticket: ticket)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}