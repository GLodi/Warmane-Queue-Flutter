import 'package:flutter/foundation.dart';

import 'package:warmane_queue_checker_flutter/data/data.dart';
import 'package:warmane_queue_checker_flutter/domain/bloc_utils/bloc_event_state.dart';

class WarmaneState extends BlocState {
  final WarmaneStateType type;
  final String message;
  final WarmaneData data;

  WarmaneState({
    @required this.type,
    this.message,
    this.data,
  });

  factory WarmaneState.notInit() =>
      WarmaneState(type: WarmaneStateType.notInit);

  factory WarmaneState.init(WarmaneData data) =>
      WarmaneState(type: WarmaneStateType.init,
        data: data);

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