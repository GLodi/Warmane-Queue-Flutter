import 'package:rxdart/rxdart.dart';
import 'dart:async';

import 'package:warmane_queue_checker_flutter/domain/managers/warmane_manager.dart';
import 'package:warmane_queue_checker_flutter/domain/bloc_utils/bloc_utils.dart';
import 'package:warmane_queue_checker_flutter/domain/eventstates/warmane_event_state.dart';

class WarmaneBloc extends BlocEventStateBase<WarmaneEvent, WarmaneState> {
  WarmaneManager _manager;

  WarmaneBloc(this._manager) :
        super(initialState: WarmaneState.notInit());

  void setup() {

  }

  @override
  Stream<WarmaneState> eventHandler(WarmaneEvent event, WarmaneState currentState) async* {
    if (event.type == WarmaneEventType.start) {
      yield WarmaneState.notInit();
      WarmaneState result;
      await _manager.getStatus()
          .handleError((e) { result = WarmaneState.error("error"); })
          .listen((status) { result = WarmaneState.init(status); })
          .asFuture();
      yield result;
    }
    if (event.type == WarmaneEventType.refresh) {
      WarmaneState result;
      await _manager.getStatus()
          .handleError((e) { result = WarmaneState.error("error"); })
          .listen((status) { result = WarmaneState.init(status); })
          .asFuture();
      yield result;
    }
  }
}