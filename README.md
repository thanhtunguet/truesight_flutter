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

Core library for Flutter applications.

Designed by: [thanhtunguet](https://github.com)

Supervisor: Le Duc Thang

# Introduction

Define a simple mechanism for defining data types (Entities) for the application.
Define a Serialize and Deserialize JSON mechanism to send/receive data from APIs.
Provide a Routing Key to define and manage deep linking for Navigation.

# Getting started

## Adding dependencies

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  # ...
  dio: ^5.0.3
  dio_cookie_manager: ^2.1.3
  bloc: ^8.1.1
  flutter_bloc: ^8.1.2
  get_it: ^7.2.0
  injectable: ^2.1.0
  objectbox: ^2.0.0
  objectbox_flutter_libs: any
  reflectable: ^4.0.5
dev_dependencies:
  # ...
  flutter_lints: ^2.0.0
  build_runner: ^2.3.3
  objectbox_generator: any
  reflectable_generator: any
  injectable_generator: any
```

# Usage

## Define your data structure

DataModel is a class that helps developers structure their data for easy serialization from JSON. To use DataModel, developers can create their own model classes and inherit from DataModel. Here's an example:

```dart
@reflector
class User extends DataModel {
  int id = 0;

  String username = "";

  String email = "";

  DateTime birthday = DateTime.now();

  int age = 0;

  User? manager;

  DataList<User> members = DataList<User>();
}
```

In this example, we create a `User` class that extends `DataModel`. We also define fields for `id`, `username`, `email`, `birthday`, `age`, `manager`, and `members`. The `members` field is of type `DataList<User>`, which is a custom class that allows the library to detect the data type of the field and initialize and assign values from JSON.

Developers can also create custom filters to filter their data. To create a custom filter, developers can inherit from the `DataFilter` class and define filters for their fields. Here's an example:

```dart
@reflector
class UserFilter extends DataFilter {
  IdFilter id = IdFilter();

  StringFilter username = StringFilter();

  StringFilter email = StringFilter();

  DateFilter birthday = DateFilter();

  NumberFilter<int> age = NumberFilter<int>();
}
```

In this example, we create a `UserFilter` class that extends `DataFilter`. We also define filters for the `id`, `username`, `email`, `birthday`, and `age` fields.

To deserialize JSON into a `User` object, developers can call the `fromJSON()` method on a `User` object and pass in the JSON as a parameter. Here's an example:

```dart
var json = {
  'id': 1,
  'username': 'John Doe',
  'email': 'johndoe@example.com',
  'birthday': '1990-01-01T01:59:00+0700',
  'manager': {
    'id': 2,
    'username': 'Jane Doe',
    'email': 'janedoe@example.com',
    'birthday': '1980-01-01T01:59:00+0700',
  },
  'members': [
    {
      'id': 3,
      'username': 'Bob Smith',
      'email': 'bobsmith@example.com',
      'birthday': '1995-01-01T01:59:00+0700',
    }
  ]
};
var user = User();
user.fromJSON(json);
```

### Full example code

```dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

import 'truesight_flutter_test.reflectable.dart';

@reflector
class User extends DataModel {
  int id = 0;

  String username = "";

  String email = "";

  DateTime birthday = DateTime.now();

  int age = 0;

  User? manager;

  // For a field of type "List", we will use the DataList class
  // This custom class allow the library to detect data type of the field
  // To intialize and assign value from JSON
  DataList<User> members = DataList<User>();
}

@reflector
class UserFilter extends DataFilter {
  IdFilter id = IdFilter();

  StringFilter username = StringFilter();

  StringFilter email = StringFilter();

  DateFilter birthday = DateFilter();

  NumberFilter<int> age = NumberFilter<int>();
}

void main() {
  initializeReflectable();
  test('deserialization', () {
    var json = {
      'id': 1,
      'username': 'John Doe',
      'email': 'johndoe@example.com',
      'birthday': '1990-01-01T01:59:00+0700',
      'manager': {
        'id': 2,
        'username': 'Jane Doe',
        'email': 'janedoe@example.com',
        'birthday': '1980-01-01T01:59:00+0700',
      },
      'members': [
        {
          'id': 3,
          'username': 'Bob Smith',
          'email': 'bobsmith@example.com',
          'birthday': '1995-01-01T01:59:00+0700',
        }
      ]
    };
    var user = User();
    user.fromJSON(json);
    expect(user.username, 'John Doe');
    expect(user.manager.runtimeType, User);
    expect(user.members, isA<DataList<User>>());

    if (kDebugMode) {
      print(user.members);
    }
  });

  test('json serialization', () {
    User johnDoe = User();
    johnDoe.username = 'John Doe';
    johnDoe.email = 'johndoe@example.com';
    johnDoe.birthday = DateTime(1990, 01, 01);
    johnDoe.id = 1;

    var jsonString = jsonEncode(johnDoe.toJSON());
    expect(jsonString,
        '{"id":1,"username":"John Doe","email":"johndoe@example.com","birthday":"1990-01-01T00:00:00.000","manager":null,"members":[]}');

    User janeDoe = User();
    janeDoe.id = 2;
    janeDoe.username = 'Jane Doe';
    janeDoe.email = 'janedoe@example.com';
    janeDoe.birthday = DateTime(1980, 01, 01);
    janeDoe.members.add(johnDoe);
    johnDoe.manager = janeDoe;
  });

  test('data filter', () {
    UserFilter userFilter = UserFilter();
    userFilter.fromJSON({
      'username': {
        'equal': 'John Doe',
      },
    });
    expect(userFilter.username.equal, 'John Doe');
  });
}

```

## Define your routes

Flutter provides developers with a way to define routes for their application screens to enable navigation to different parts of the app. This is achieved using a mechanism known as deep linking. In this guide, we'll take a look at how to define routes in Flutter and use them to navigate through different screens of the app.

To define routes in Flutter, we make use of a concept known as a `routing key`. A routing key is a unique identifier for each screen in your app. We'll define our routing keys using the `UsePageRoute` decorator.

Flutter supports deep linking very well. So we define a term of `routing key` to identify your application's screens.

### Routing pages

```dart
@reflector
@UsePageRoute('/login')
class LoginPage extends StatefulWidget {
  //
}
```

In the example above, we've defined a routing key for the login screen using the `UsePageRoute` decorator. The routing key for the login screen is `/login`.

We can define routing keys for all the screens in our app using this same approach. Each screen should have a unique routing key.

### Navigating to a Screen

Now that we've defined our routing keys, we can use them to navigate to different screens in our app. We'll use the `GoRouter` class to accomplish this. The `GoRouter` class provides a `go` method that accepts a routing key and navigates to the corresponding screen.

```dart
GoRouter.of(context).go(getRoutingKey(LoginPage));
```

In the example above, we're using the `getRoutingKey` method to obtain the routing key for the login screen, and passing it to the `go` method of the `GoRouter` class. This will navigate to the login screen.

And that's it! With this simple mechanism, we can easily define routes and navigate through different screens in our Flutter app.

## Define your data sources

### HttpRepository

The `HttpRepository` class is an abstract class that extends the `Repository` class. It is designed to serve as a base class for creating repositories that interact with remote HTTP APIs using the `Dio` HTTP client library.

Here is a breakdown of the key features and methods provided by the `HttpRepository` class:

- `dio`: an instance of the `Dio` class, which is used to make HTTP requests and handle responses.
- `baseUrl`: a getter and setter for the base URL of the API. This is the URL that will be used as a prefix for all API requests made through this repository.
- `contentType`: a getter and setter for the content type of the HTTP request body. By default, this is set to `application/json`.
- `post()`, `get()`, `put()`, `patch()`, and `delete()`: convenience methods for making HTTP requests using the corresponding HTTP methods. These methods all accept similar parameters as their counterparts in the `Dio` class, and return a `Future<Response>`.

To use this class in your project, you can create a new class that extends `HttpRepository`, and define methods for interacting with the specific API you are working with. For example, if you were building an app that interacted with a REST API for managing tasks, you could create a `TaskRepository` class that extends `HttpRepository`, and define methods like `getAllTasks()`, `getTaskById()`, `createTask()`, etc., that make use of the `get()`, `post()`, `put()`, and `delete()` methods provided by `HttpRepository`.

Here's an example of what the implementation of a `TaskRepository` class might look like:

```dart
part of 'repositories.dart';

class TaskRepository extends HttpRepository {
  TaskRepository({
    String? baseUrl,
  }) : super(baseUrl: baseUrl);

  Future<List<Task>> getAllTasks() async {
    final response = await get('/tasks');
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> getTaskById(int id) async {
    final response = await get('/tasks/$id');
    if (response.statusCode == 200) {
      return Task.fromJson(response.data);
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<Task> createTask(Task task) async {
    final response = await post('/tasks', data: task.toJson());
    if (response.statusCode == 201) {
      return Task.fromJson(response.data);
    } else {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await put('/tasks/${task.id}', data: task.toJson());
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await delete('/tasks/$id');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete task');
    }
  }
}
```

In this example, the `TaskRepository` class defines methods for interacting with a hypothetical `/tasks` endpoint, using the `get()`, `post()`, `put()`, and `delete()` methods provided by `HttpRepository`. Each method returns a `Future` that resolves to either the requested data, or an error message if the request failed.

## Additional information

Updating...
