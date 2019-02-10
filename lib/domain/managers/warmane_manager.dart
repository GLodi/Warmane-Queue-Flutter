import 'package:rxdart/rxdart.dart';

import 'package:warmane_queue_checker_flutter/data/data.dart';

class WarmaneManager {
  WebHelper _webHelper;

  WarmaneManager(this._webHelper);

  Observable<WarmaneData> getStatus() =>
      Observable.fromFuture(_webHelper.getStatus())
          .handleError((e) => throw e);
}