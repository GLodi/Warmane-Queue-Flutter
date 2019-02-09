import 'package:flutter/material.dart';

import 'package:warmane_queue_checker_flutter/domain/domain.dart';

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
                    color: Theme.of(context).hintColor,
                    fontFamily: "Roboto",
                    fontSize: 20.0,
                  ),
                ),
              );
            }
            case WarmaneStateType.init : {
              return Text(
                state.message,
                style: new TextStyle(
                  color: Theme.of(context).hintColor,
                  fontFamily: "Roboto",
                  fontSize: 20.0,
                ),
              );
            }
          }
        },
      ),
    );
  }

}