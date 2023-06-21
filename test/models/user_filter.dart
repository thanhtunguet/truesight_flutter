import 'package:truesight_flutter/truesight_flutter.dart';

@reflector
class UserFilter extends DataFilter {
  IdFilter id = IdFilter();

  StringFilter username = StringFilter();

  StringFilter email = StringFilter();

  DateFilter birthday = DateFilter();

  NumberFilter<int> age = NumberFilter<int>();
}
