part of 'filters.dart';

@reflector
abstract class AbstractFilter {
  AbstractFilter();

  void fromJSON(Map<String, dynamic> json);

  Map<String, dynamic> toJSON();
}
