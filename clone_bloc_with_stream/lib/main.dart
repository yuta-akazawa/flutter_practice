import 'package:flutter/material.dart';
import './ticker/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/bloc.dart';

void main() => runApp(StreamApp());

class StreamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutte Demo',
      home: StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  _StreamHomePage createState() => _StreamHomePage();
}

class _StreamHomePage extends State<StreamHomePage> {
  Ticker _ticker;
  TickerBloc _tickerBloc;

  @override
  void initState(){
    super.initState();
    _ticker = Ticker();
    _tickerBloc = TickerBloc(_ticker);
  }

 @override
 Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc with Streams'),
      ),
      body: BlocBuilder(
          bloc: _tickerBloc,
          builder: (BuildContext context, TickerState state){
            if(state is Initial){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Press the floating button to start'),
                  ],
                ),
              );
            } else if(state is Update) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Tick #${state.count}'),
                  ],
                ),
              );
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
            _tickerBloc.dispatch(StartTicker());
            },
        tooltip: 'Start',
        child: Icon(Icons.timer),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _tickerBloc.dispose();
    super.dispose();
  }
}