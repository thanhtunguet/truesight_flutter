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

## Table of Contents


- [truesight\_flutter](#truesight_flutter)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
  - [Usage](#usage)
    - [JSON Serialization](#json-serialization)
      - [Mapping Data from JSON](#mapping-data-from-json)
      - [Converting to JSON](#converting-to-json)
    - [Advanced Filters](#advanced-filters)
    - [HTTP Requests](#http-requests)
    - [TrueSightService](#truesightservice)
      - [Initialization](#initialization)
        - [`initialize`](#initialize)
          - [Parameters](#parameters)
          - [Usage](#usage-1)
      - [Properties](#properties)
        - [`faceIdEnabled`](#faceidenabled)
          - [Getter](#getter)
          - [Setter](#setter)
          - [Usage](#usage-2)
        - [`baseApiUrl`](#baseapiurl)
          - [Getter](#getter-1)
          - [Setter](#setter-1)
          - [Usage](#usage-3)
      - [Private Methods](#private-methods)
        - [`_getOrCreate`](#_getorcreate)
          - [Parameters](#parameters-1)
          - [Returns](#returns)
      - [Example](#example)
  - [Custom Image Provider](#custom-image-provider)
    - [Overview](#overview)
    - [Constructor](#constructor)
    - [Methods](#methods)
    - [Example Usage](#example-usage)
  - [Widget Documentation](#widget-documentation)
  - [Cookie Management](#cookie-management)
    - [Overview](#overview-1)
    - [Storing Cookies](#storing-cookies)
    - [Retrieving Cookies](#retrieving-cookies)
    - [Clearing Cookies](#clearing-cookies)
    - [Cookie Extension Methods](#cookie-extension-methods)
    - [Example Usage](#example-usage-1)
  - [Date and Time Formats](#date-and-time-formats)
    - [Available Formats](#available-formats)
    - [Formatting Dates](#formatting-dates)
    - [Extension Method for DateTime](#extension-method-for-datetime)
    - [Summary](#summary)
  - [Additional Information](#additional-information)


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

## Custom Image Provider

A custom image provider designed to fetch images with appended authentication tokens from the server.

### Overview

The `TrueSightImageProvider` class extends `ImageProvider<Uri>` and modifies image loading behavior to include authentication tokens fetched from cookies.

### Constructor

```dart
TrueSightImageProvider(String url)
```

Constructs an instance of `TrueSightImageProvider` with the provided image URL.

### Methods

- **obtainKey(ImageConfiguration configuration)**: Asynchronously obtains a key for the image. Appends authentication token to the URL's query parameters.
  
- **loadImage(Uri key, ImageDecoderCallback decode)**: Loads the image from the specified URL with authentication headers using an HTTP client. Tracks loading progress with chunk events.

### Example Usage

```dart
import 'package:flutter/material.dart';

class MyImageWidget extends StatelessWidget {
  final String imageUrl = 'https://example.com/image.jpg';

  @override
  Widget build(BuildContext context) {
    final imageProvider = TrueSightImageProvider(imageUrl);

    return Image(
      image: imageProvider,
      fit: BoxFit.cover,
    );
  }
}
```

In this example, `TrueSightImageProvider` is used as the image provider for an `Image` widget, ensuring the image is fetched with proper authentication.


## Widget Documentation

- [AppNavigationBar](docs/app_navigation_bar.md)
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

## Cookie Management

In our app, cookies are managed to handle user sessions and authentication tokens efficiently. The cookies are stored using the `SharedPreferences` package, which allows for persistent storage of key-value pairs on the device.

### Overview

Cookies are essential for maintaining user sessions and handling authentication. The following extension methods and functions facilitate the storage, retrieval, and clearing of cookies in the app.

### Storing Cookies

Cookies are parsed from the `Set-Cookie` header and stored with a prefix in the `SharedPreferences`. The `parseSetCookie` function handles this parsing:

```dart
Map<String, String> parseSetCookie(String setCookieString) {
  Map<String, String> cookies = {};
  List<String> parts = setCookieString.split('; ');
  if (parts.isNotEmpty && parts[0].contains('=')) {
    List<String> keyValue = parts[0].split('=');
    if (keyValue.length == 2) {
      cookies[_getCookieKey(keyValue[0])] = keyValue[1];
    }
  }
  return cookies;
}
```

### Retrieving Cookies

Cookies are retrieved from the `SharedPreferences` using the `getCookies` function. This function retrieves all keys with the specified prefix and constructs a map of cookies:

```dart
Future<Map<String, dynamic>> getCookies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Set<String> keys = prefs.getKeys();
  final Map<String, dynamic> prefsMap = {};

  for (String key in keys) {
    if (_isCookieKey(key)) {
      prefsMap[_getCookieKeyReversed(key)] = prefs.get(key);
    }
  }

  return prefsMap;
}
```

### Clearing Cookies

Cookies can be cleared from the `SharedPreferences` using the `clearCookies` function. This function removes all keys with the specified prefix:

```dart
Future<void> clearCookies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Set<String> keys = prefs.getKeys();

  for (String key in keys) {
    if (_isCookieKey(key)) {
      prefs.remove(key);
    }
  }
}
```

### Cookie Extension Methods

The extension methods on `Map<String, dynamic>` provide easy access to specific cookies, such as `token` and `refreshToken`:

```dart
extension TrueSightCookies on Map<String, dynamic> {
  String? get token => this['Token'];
  String? get refreshToken => this['RefreshToken'];
  bool get hasToken => this['Token'] != null;
  bool get hasRefreshToken => this['RefreshToken'] != null;
}
```

These methods simplify the retrieval and usage of cookies in various parts of the app.

### Example Usage

Here is an example of how to use the cookie management functions in your app:

```dart
// Parsing and storing a Set-Cookie header
String setCookieHeader = 'Token=abc123; Path=/; HttpOnly';
Map<String, String> cookies = parseSetCookie(setCookieHeader);
// Store the parsed cookies using SharedPreferences
// ...

// Retrieving stored cookies
Future<void> printStoredCookies() async {
  Map<String, dynamic> cookies = await getCookies();
  print('Stored Token: ${cookies.token}');
}

// Clearing stored cookies
Future<void> clearStoredCookies() async {
  await clearCookies();
  print('Cookies cleared');
}
```

With these functions and extensions, managing cookies in your app becomes straightforward and efficient.

## Date and Time Formats

Our app uses various date and time formats to ensure consistency and readability, especially tailored for the Vietnamese locale. The formats are defined in the `DateTimeFormatsVN` class and can be easily used throughout the app.

### Available Formats

The `DateTimeFormatsVN` class defines several common date and time formats:

- **Full Date and Time**: `dd/MM/yyyy HH:mm:ss`
  - Example: `01/01/2024 14:30:45`
- **Date and Time without Seconds**: `dd/MM/yyyy HH:mm`
  - Example: `01/01/2024 14:30`
- **Date Only**: `dd/MM/yyyy`
  - Example: `01/01/2024`
- **Time Only**: `HH:mm:ss`
  - Example: `14:30:45`
- **Day and Month Only**: `dd/MM`
  - Example: `01/01`
- **Year Only**: `yyyy`
  - Example: `2024`
- **Date with Day Name**: `EEEE, dd/MM/yyyy`
  - Example: `Thứ Hai, 01/01/2024`
- **Date with Month Name**: `dd MMMM yyyy`
  - Example: `01 Tháng Giêng 2024`
- **Short Date with Month Name**: `dd MMM`
  - Example: `01 Thg 01`

### Formatting Dates

The `DateTimeFormatsVN` class includes a helper function to format `DateTime` objects using the specified formats:

```dart
static String format(DateTime dateTime, String format) {
  return DateFormat(format, 'vi').format(dateTime);
}
```

You can use this function to format dates according to the predefined formats. For example:

```dart
DateTime now = DateTime.now();
String formattedDate = DateTimeFormatsVN.format(now, DateTimeFormatsVN.dateTime);
print(formattedDate); // Output: 01/01/2024 14:30:45
```

### Extension Method for DateTime

We have also provided an extension method on the `DateTime` class to simplify the formatting process. This method uses a default format but allows for customization:

```dart
extension DateTimeFormatter on DateTime {
  String format({
    String dateFormat = DateTimeFormatsVN.dateOnly,
  }) {
    return DateFormat(dateFormat).format(toLocal());
  }
}
```

Example usage of the extension method:

```dart
DateTime now = DateTime.now();
String formattedDate = now.format();
print(formattedDate); // Output: 01/01/2024

String customFormattedDate = now.format(dateFormat: DateTimeFormatsVN.dateWithDayName);
print(customFormattedDate); // Output: Thứ Hai, 01/01/2024
```

### Summary

By using the `DateTimeFormatsVN` class and the `DateTimeFormatter` extension, you can easily format dates and times in your app, ensuring consistency and localization for Vietnamese users.

## Additional Information

This package is under development. Feel free to create an issue.

---

This documentation provides an overview of the `truesight_flutter` library, explaining its features, how to get started, and how to use its JSON serialization, HTTP request management, and `TrueSightService` capabilities. The examples have been enhanced for better understanding and practical usage.
