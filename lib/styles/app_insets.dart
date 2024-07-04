part of 'styles.dart';

class AppInsets extends EdgeInsets {
  static const allSmall = AppInsets.all(SpacingSize.small);

  static const allMedium = AppInsets.all(SpacingSize.medium);

  static const allLarge = AppInsets.all(SpacingSize.large);

  static const verticalSmall = AppInsets.vertical(SpacingSize.small);

  static const horizontalMedium = AppInsets.horizontal(SpacingSize.medium);

  static const bothFull = AppInsets.all(16);

  static const horizontalFull = AppInsets.horizontal(16);

  static const verticalHalf = AppInsets.vertical(8);

  static const verticalQuater = AppInsets.vertical(4);

  static const zero = AppInsets.all(0);

  const AppInsets.all(double value) : super.all(value);

  const AppInsets.vertical(double value) : super.symmetric(vertical: value);

  const AppInsets.horizontal(double value) : super.symmetric(horizontal: value);
}
