import 'package:flutter/foundation.dart';

import 'package:warmane_queue_checker_flutter/domain/bloc_utils/bloc_event_state.dart';

class WarmaneState extends BlocState {
  final String message;
  final WarmaneStateType type;

  WarmaneState({
    @required this.type,
    this.message,
  });

  factory WarmaneState.notInit() =>
      WarmaneState(type: WarmaneStateType.notInit);

  factory WarmaneState.init(String message) =>
      WarmaneState(type: WarmaneStateType.init,
        message: message);

  factory WarmaneState.error(String error) =>
      WarmaneState(type: WarmaneStateType.error,
        message: error);
}

enum WarmaneStateType {
  init,
  notInit,
  error,
}

class WarmaneEvent extends BlocEvent {
  final WarmaneEventType type;

  WarmaneEvent({
    this.type : WarmaneEventType.start
  }) : assert(type != null);
}

enum WarmaneEventType {
  start,
}