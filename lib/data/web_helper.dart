import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import 'net_utils.dart';

class WebHelper {
  final url ="https://www.warmane.com/";
  final NetUtils _net;

  WebHelper(this._net);

  Future<String> getStatus() async {
    return _net.get(url)
        .then((response) {
          int b = 0;
          var document = parse(response.toString());
          var statistic = document.getElementById("wm-ui-plugin-statistics");
          var tr = statistic.getElementsByTagName("tr");
          var outNum = tr[0].nodes[5].nodes[1].nodes;
          var lorNum = tr[1].nodes[5].nodes[1].nodes;
          int a = 0;
          return 'a';
        })
        .catchError((e) => throw e);
  }

}