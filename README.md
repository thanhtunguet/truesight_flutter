<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Flutter core library for TrueSight team

## Features

- Coming soon...

## Getting started

```sh
flutter pub add truesight_flutter
```

### Adding dependencies

```yaml
dependencies:
  # ...
  bloc: ^8.1.1
  dio: ^5.0.3
  dio_cookie_manager: ^2.1.3

  flutter_bloc: ^8.1.2
  get_it: ^7.2.0
  injectable: ^2.1.0
  objectbox: ^2.0.0
  reflectable: ^4.0.5
dev_dependencies:
  # ...
  flutter_lints: ^2.0.0
  build_runner: ^2.3.3
```

## Usage

### Define a DataModel

```dart
import 'package:truesight_flutter/truesight_flutter.dart';

@reflector
class User extends DataModel {
  int id = 0;

  String username = "";

  String email = "";

  DateTime birthday = DateTime.now();

  User? manager;

  DataList<User> members = DataList<User>();
}
```

## Additional information

Updating...
