import 'package:intl/intl.dart';

extension NumberFormatter on num {
  String asMoney({bool hasDecimals = false}) {
    var formatter = NumberFormat(hasDecimals ? '###,###.000' : '###,###');
    return formatter.format(this);
  }
}
