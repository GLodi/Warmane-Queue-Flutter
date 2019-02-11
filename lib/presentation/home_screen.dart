import 'package:flutter/material.dart';
import 'dart:async';

import 'package:warmane_queue_checker_flutter/domain/domain.dart';

List<String> servers = ["Outland", "Lordaeron", "Icecrown",
                        "Blackrock", "Frostwolf"];

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  WarmaneBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<WarmaneBloc>(context);
    bloc.setup();
    bloc.emitEvent(WarmaneEvent(type: WarmaneEventType.start));
    Timer.periodic(Duration(seconds: 5), (t) {
      bloc.emitEvent(WarmaneEvent(type: WarmaneEventType.refresh));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocEventStateBuilder<WarmaneEvent, WarmaneState>(
        bloc: bloc,
        builder: (context, state) {
          switch(state.type) {
            case WarmaneStateType.notInit : {
              return Center(child: CircularProgressIndicator());
            }
            case WarmaneStateType.error : {
              return Center(
                child: Text(
                  state.message,
                  style: new TextStyle(
                    color: Color.fromRGBO(126, 140, 29, 100),
                    fontFamily: "Futura Book Regular",
                    fontSize: 20.0,
                  ),
                ),
              );
            }
            case WarmaneStateType.init : {
              return initScreen(state);
            }
          }
        },
      ),
    );
  }

  Widget initScreen(WarmaneState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: <Widget>[
          Image.asset("assets/warmane.png"),
          Flexible(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return index != 5 ? ListTile(
                  leading:
                  index != 0 && index != 4 ? Image.asset('assets/wotlk.png') : (
                      index == 0 ? Image.asset('assets/tbc.png') : Image.asset('assets/mop.png')),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        servers[index],
                        style: new TextStyle(
                          color: state.data.q[index] == null ?
                          Color.fromRGBO(126, 140, 29, 100) :
                          Color.fromRGBO(214, 149, 35, 100),
                          fontFamily: "Futura Book Regular",
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        state.data.players[index].toString(),
                        style: new TextStyle(
                          color: state.data.q[index] == null ?
                          Color.fromRGBO(126, 140, 29, 100) :
                          Color.fromRGBO(214, 149, 35, 100),
                          fontFamily: "Futura Book Regular",
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ) :
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      "Total players online: " + state.data.total.toString(),
                      style: new TextStyle(
                        color: Color.fromRGBO(126, 140, 29, 100),
                        fontFamily: "Futura Book Regular",
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

}