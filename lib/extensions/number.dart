import 'package:intl/intl.dart';

extension NumberFormatter on num {
  String asMoney({
    bool hasDecimals = true,
    String currency = 'VND',
  }) {
    var formatter = NumberFormat(hasDecimals ? '###,###.000' : '###,###');
    var formattedNum = this == 0 ? '0' : formatter.format(this);
    if (formattedNum.endsWith('.000')) {
      formattedNum = formattedNum.substring(0, formattedNum.length - 4);
    }
    return '$formattedNum $currency';
  }
}

extension IntegerFormatter on int {
  String asMoney({
    String currency = 'VND',
  }) {
    return (this as num).asMoney(hasDecimals: false, currency: currency);
  }
}
