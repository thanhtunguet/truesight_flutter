import 'package:intl/intl.dart';

extension NumberFormatter on num {
  String asMoney({
    bool hasDecimals = true,
    String currency = 'VND',
  }) {
    var formatter = NumberFormat(hasDecimals ? '###,###.000' : '###,###');
    return '${formatter.format(this)} $currency';
  }
}

extension IntegerFormatter on int {
  String asMoney({
    String currency = 'VND',
  }) {
    return (this as num).asMoney(hasDecimals: false, currency: currency);
  }
}
