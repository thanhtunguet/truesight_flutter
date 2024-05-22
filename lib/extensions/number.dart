import 'package:intl/intl.dart';

extension NumberFormatter on num {
  String asMoney({bool hasDecimals = false}) {
    var formatter = NumberFormat(hasDecimals ? '###,###.000' : '###,###');
    return formatter.format(this);
  }
}

extension DoubleFormatter on double {
  String asMoney({bool hasDecimals = false}) {
    var formatter = NumberFormat(hasDecimals ? '###,###.000' : '###,###');
    return formatter.format(this);
  }
}

extension IntegerFormatter on double {
  String asMoney({bool hasDecimals = false}) {
    var formatter = NumberFormat(hasDecimals ? '###,###.000' : '###,###');
    return formatter.format(this);
  }
}
