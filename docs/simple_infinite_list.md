# SimpleInfiniteList

A widget that provides an infinite scrolling list with pagination and data fetching capabilities. It integrates with the TrueSight library's data models, filters, and repositories.

## Properties

- **itemBuilder** (`Widget Function(BuildContext context, T item, int index)`): A function that builds each item in the list.
- **filterInitializer** (`TFilter Function()`): A function that initializes the filter used for fetching data.
- **repository** (`TRepo`): The repository that handles data fetching.

## Example

Here's an example of how to use the `SimpleInfiniteList` widget in a Flutter application:

```dart
import 'package:flutter/material.dart';
import 'package:truesight_flutter/json/json.dart';
import 'package:truesight_flutter/repository/base_repository.dart';
import 'package:truesight_flutter/widgets/simple_infinite_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SimpleInfiniteList Example'),
        ),
        body: ExampleList(),
      ),
    );
  }
}

class ExampleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleInfiniteList<ExampleModel, ExampleFilter, ExampleRepository>(
      itemBuilder: (context, item, index) {
        return ListTile(
          title: Text(item.name),
        );
      },
      repository: ExampleRepository(),
      filterInitializer: () => ExampleFilter(),
    );
  }
}

class ExampleModel extends DataModel {
  final String name;

  ExampleModel(this.name);

  @override
  List<JsonField> get fields => [JsonString('name', isRequired: true)];
}

class ExampleFilter extends DataFilter {}

class ExampleRepository extends BaseRepository<ExampleModel, ExampleFilter> {
  @override
  Future<List<ExampleModel>> list(ExampleFilter filter) async {
    // Implement data fetching logic
    return [
      ExampleModel('Item 1'),
      ExampleModel('Item 2'),
      ExampleModel('Item 3'),
    ];
  }

  @override
  Future<int> count(ExampleFilter filter) async {
    // Implement count logic
    return 3;
  }
}
```

In this example, `SimpleInfiniteList` is used to create an infinite scrolling list. The `ExampleModel`, `ExampleFilter`, and `ExampleRepository` classes are used to manage data fetching and pagination.

## Additional Information

This widget is part of the `truesight_flutter` library and leverages the `infinite_scroll_pagination` package for pagination.

## Methods

### `initState`

Initializes the state and sets up the filter and page request listener.

### `dispose`

Disposes the paging controller to free up resources.

### `_handleFetchNewData`

Fetches new data based on the current page key and updates the paging controller.

- **Parameters**:
  - `pageKey` (`int`): The key representing the current page. Default is `0`.

### `_onRefresh`

Handles the refresh action to reload the data.

- **Returns**: `Future<void>` - A future that completes when the refresh action is done.

## Widget Build

The `build` method returns a `RefreshIndicator` containing a `PagedListView` that displays the list of items with infinite scrolling and pagination support.
