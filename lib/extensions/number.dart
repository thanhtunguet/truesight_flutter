import 'package:intl/intl.dart';

extension NumberFormatter on num {
  String asMoney({
    bool hasDecimals = false,
    String currency = 'VND',
  }) {
    var formatter = NumberFormat(hasDecimals ? '###,###.000' : '###,###');
    return '${formatter.format(this)} $currency';
  }
}

extension DoubleFormatter on double {
  String asMoney({
    bool hasDecimals = false,
    String currency = 'VND',
  }) {
    return (this as num).asMoney(hasDecimals: hasDecimals, currency: currency);
  }
}

extension IntegerFormatter on double {
  String asMoney({
    bool hasDecimals = false,
    String currency = 'VND',
  }) {
    return (this as num).asMoney(hasDecimals: hasDecimals, currency: currency);
  }
}
