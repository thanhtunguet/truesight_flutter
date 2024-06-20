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

# truesight_flutter

_Core library for TrueSight team's Flutter applications._

## Features

- Convenient JSON serialization with an auto-mapper mechanism
- Custom filter building for backend integration
- HTTP request management with built-in HTTPRepository
- Integration with `go_router` as the default routing mechanism
- Various other utilities

## Getting Started

To install this package, run:

```sh
flutter pub add truesight_flutter go_router intl
```

## Usage

### JSON Serialization

The library provides the following classes:

- `DataModel`: Represents an entity in the application, typically mapped to a table in the backend database.
- `DataFilter`: Filter set for a specific `DataModel`.

Convention: Each `DataModel` should have a corresponding `DataFilter`.

Entities and filters in the application should extend these two classes.

To define a new class, consider the following example with the `AppUser` class:

```dart
class AppUser extends DataModel {
  @override
  List<JsonField> get fields => [
    username,
    password,
    email,
    isAdmin,
    dateOfBirth,
    age,
    level,
    manager,
    members,
  ];

  JsonString username = JsonString('username', isRequired: false, helper: 'Username of the user');
  JsonString password = JsonString('password', isRequired: false, helper: 'Password of the user');
  JsonString email = JsonString('email', isRequired: false, helper: 'Email of the user');
  JsonBoolean isAdmin = JsonBoolean('isAdmin', isRequired: false, helper: 'Is the user an admin');
  JsonDate dateOfBirth = JsonDate('dateOfBirth', isRequired: false, helper: 'User\'s date of birth');
  JsonInteger age = JsonInteger('age', isRequired: false, helper: 'Age of the user');
  JsonDouble level = JsonDouble('level', isRequired: false, helper: 'Level of the user');
  JsonObject<AppUser> manager = JsonObject('manager', isRequired: false, helper: 'Manager of the user');
  JsonList<AppUser> members = JsonList<AppUser>('members', isRequired: false, helper: 'Members that this user manages');
}
```

Explanation:

- `fields` getter: These are the JSON fields that will be automatically mapped from JSON when fetching data from the backend.
- JSON data fields are represented by the following classes:

| Class         | Dart Data Type    |
|---------------|-------------------|
| `JsonDate`    | `DateTime`        |
| `JsonBoolean` | `bool`            |
| `JsonString`  | `String`          |
| `JsonInteger` | `int`             |
| `JsonDouble`  | `double`          |
| `JsonNumber`  | `num`             |
| `JsonObject`  | `DataModel`       |
| `JsonList`    | `List<DataModel>` |

The `JsonXYZ` classes inherit from `JsonField`.

#### Mapping Data from JSON

```dart
final json = await requestFromAPI();
AppUser user = AppUser();
user.fromJSON(json);
```

#### Converting to JSON

```dart
AppUser user = AppUser();
user.toJSON(); // Returns the JSON representation of the user, typically a Dart Map object.
user.toString(); // Returns the JSON representation of the user as a Dart String.
```

### Advanced Filters

Similar to JSON classes, the library defines `FilterField` data types as follows:

| Class          | Dart Data Type | JSON Data Type |
|----------------|----------------|----------------|
| `StringFilter` | `String`       | `JsonString`   |
| `DateFilter`   | `DateTime`     | `JsonDate`     |
| `GuidFilter`   | `String`       | `JsonString`   |
| `IdFilter`     | `int`          | `JsonInteger`  |
| `IntFilter`    | `int`          | `JsonInteger`  |
| `DoubleFilter` | `double`       | `JsonDouble`   |
| `NumberFilter` | `num`          | `JsonNumber`   |

### HTTP Requests

The repository class performs API calls to the backend to fetch data.

Each `HttpRepository` class can represent a set of APIs corresponding to a specific business logic, such as user login (`UserRepository`) or product management (`ProductRepository`).

The `HttpRepository` class can be used with the `@singleton` annotation from the `injectable` package combined with `get_it` for dependency injection.

Each method in `HttpRepository` corresponds to a specific API.

```dart
@singleton
class UserRepository extends HttpRepository {
  @override
  InterceptorsWrapper interceptorWrapper = InterceptorsWrapper();

  @override
  String? get baseUrl => 'https://app.example.com';

  Future<AppUser> login(String username, String password) {
    return post("/login", data: {
      'username': username,
      'password': password,
    })
    .then((response) => response.body<AppUser>(AppUser));
  }
}
```

### TrueSightService

The `TrueSightService` is a singleton class designed to handle application-wide settings and configuration management using Hive for local storage and dotenv for environment variable management. This service provides a way to initialize necessary configurations and manage settings like `faceIdEnabled` and `baseApiUrl`.

#### Initialization

##### `initialize`

Initializes the service with optional parameters to enable dotenv and Hive.

###### Parameters
- `enableDotenv` (bool): If `true`, loads environment variables using the `flutter_dotenv` package. Default is `true`.
- `enableHive` (bool): If `true`, initializes Hive and opens a box for storage. Default is `true`.

###### Usage
```dart
await truesightService.initialize(
  enableDotenv: true,
  enableHive: true,
);
```

#### Properties

##### `faceIdEnabled`

Getter and setter for the `faceIdEnabled` setting. This setting controls whether Face ID is enabled in the application.

###### Getter
Returns a `bool` indicating whether Face ID is enabled. If the value is not set, it defaults to `true`.

###### Setter
Sets the `faceIdEnabled` value.

###### Usage
```dart
// Get faceIdEnabled
bool isFaceIdEnabled = truesightService.faceIdEnabled;

// Set faceIdEnabled
truesightService.faceIdEnabled = false;
```

##### `baseApiUrl`

Getter and setter for the `baseApiUrl` setting. This setting holds the base URL for the API. If the value is not set, it falls back to the environment variable `BASE_API_URL`.

###### Getter
Returns a `String` containing the base API URL. If the value is not set in Hive, it retrieves the value from the environment variables.

###### Setter
Sets the `baseApiUrl` value.

###### Usage
```dart
// Get baseApiUrl
String apiUrl = truesightService.baseApiUrl;

// Set baseApiUrl
truesightService.baseApiUrl = 'https://api.example.com';
```

#### Private Methods

##### `_getOrCreate`

A utility method to retrieve a value from Hive or create it with a default value if it does not exist.

###### Parameters
- `key` (String): The key for the value in Hive.
- `defaultValue` (dynamic): The default value to use if the key does not exist.

###### Returns
- The value associated with the key, or the default value if the key does not exist.

#### Example

Here's an example of how to use the `TrueSightService` in a Flutter application:

```dart
import 'package:flutter/material.dart';
import 'path_to_your_service/truesight_app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await truesightService.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Truesight App Service Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Face ID Enabled: ${truesightService.faceIdEnabled}'),
              Text('Base API URL: ${truesightService.baseApiUrl}'),
              ElevatedButton(
                onPressed: () {
                  truesightService.faceIdEnabled = !truesightService.faceIdEnabled;
                },
                child: Text('Toggle Face ID'),
              ),
              ElevatedButton(
                onPressed: () {
                  truesightService.baseApiUrl = 'https://newapi.example.com';
                },
                child: Text('Set New API URL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Widget Documentation

- [AppNavigationBar](docs/app_navigation_bar.md)
- [AppNavigationBarItem](docs/app_navigation_bar_item.md)
- [AppTitle](docs/app_title.md)
- [BodyText](docs/body_text.md)
- [CarbonButton](docs/carbon_button.md)
- [ConfirmationDialog](docs/confirmation_dialog.md)
- [EllipsisText](docs/ellipsis_text.md)
- [GoBackButton](docs/go_back_button.md)
- [IconPlaceholder](docs/icon_placeholder.md)
- [ImagePlaceholder](docs/image_placeholder.md)
- [SignInButton](docs/sign_in_button.md)
- [SimpleInfiniteList](docs/simple_infinite_list.md)
- [StatefulTextFormField](docs/stateful_text_form_field.md)


## Additional Information

This package is under development. Feel free to create an issue.

---

This documentation provides an overview of the `truesight_flutter` library, explaining its features, how to get started, and how to use its JSON serialization, HTTP request management, and `TrueSightService` capabilities. The examples have been enhanced for better understanding and practical usage.
