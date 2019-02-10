import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

import 'net_utils.dart';
import 'warmane_data.dart';

class WebHelper {
  final url ="https://www.warmane.com/";
  final NetUtils _net;

  WebHelper(this._net);

  Future<WarmaneData> getStatus() async {
    return _net.get(url)
        .then((response) {
          var document = parse(response.toString());
          var statistic = document.getElementById("wm-ui-plugin-statistics");
          var tr = statistic.getElementsByTagName("tr");
          WarmaneData data = new WarmaneData();
          List<int> dataList = new List(5);
          List<int> queueList = new List(5);
          for (int i = 0; i <= 8; i+=2) {
            try {
              var a = tr[i].nodes[5].nodes[1].nodes[0].toString();
              var b = a.substring(1, a.lastIndexOf('\"'));
              dataList[(i/2).round()] = int.parse(b);
              var c = tr[i].attributes.entries.elementAt(1).value;
              var d = c.substring(c.lastIndexOf(' '), c.length);
              queueList[(i/2).round()] = int.parse(d);
            } catch (e) {}
          }
          try {
            var a = tr[12].nodes[1].nodes[1].nodes[0].toString();
            var b = a.substring(1, a.lastIndexOf('\"'));
            data.total = int.parse(b);
          } catch (e) {}
          data.players = dataList;
          data.q = queueList;
          return data;
        })
        .catchError((e) => throw e);
  }

}