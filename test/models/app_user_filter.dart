import 'package:truesight_flutter/truesight_flutter.dart';

class AppUserFilter extends DataFilter {
  @override
  List<FilterField> get fields => [
        username,
        age,
      ];

  StringFilter username = StringFilter("username");

  IntFilter age = IntFilter("age");

  DateFilter dateOfBirth = DateFilter("dateOfBirth");
}
