# App Navigation Bar

A navigation bar widget designed to display navigation items horizontally at the bottom of the screen.

## `AppNavigationBar` Widget

Displays a navigation bar container with a row of navigation items.

### Properties

- **index** (`int`): The index of the currently active navigation item.
- **items** (`List<Widget>`): The list of navigation items to display in the navigation bar.

### Example

```dart
import 'package:flutter/material.dart';
import 'package:truesight_flutter/widgets/app_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Navigation Bar Example'),
        ),
        body: ExampleScreen(),
      ),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  int _currentIndex = 0;

  void _onIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Selected Index: $_currentIndex',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        AppNavigationBar(
          index: _currentIndex,
          items: [
            AppNavigationBarItem(
              icon: Icons.home,
              label: 'Home',
              isActive: _currentIndex == 0,
              onIndexChanged: () => _onIndexChanged(0),
            ),
            AppNavigationBarItem(
              icon: Icons.search,
              label: 'Search',
              isActive: _currentIndex == 1,
              onIndexChanged: () => _onIndexChanged(1),
            ),
            AppNavigationBarItem(
              icon: Icons.settings,
              label: 'Settings',
              isActive: _currentIndex == 2,
              onIndexChanged: () => _onIndexChanged(2),
            ),
          ],
        ),
      ],
    );
  }
}
```

In this example, `AppNavigationBar` is used to create a navigation bar with three `AppNavigationBarItem` widgets representing different navigation options.

## `AppNavigationBarItem` Widget

Represents an individual navigation item within the `AppNavigationBar`.

### Properties

- **icon** (`IconData`): The icon to display for the navigation item.
- **activeIcon** (`IconData?`): The icon to display when the navigation item is active (optional).
- **image** (`Widget?`): An optional image widget to display instead of the icon.
- **label** (`String`): The label text for the navigation item.
- **isActive** (`bool`): Indicates whether the navigation item is currently active.
- **onIndexChanged** (`void Function()?`): Callback function invoked when the navigation item is tapped.

### Example

```dart
AppNavigationBarItem(
  icon: Icons.home,
  label: 'Home',
  isActive: _currentIndex == 0,
  onIndexChanged: () => _onIndexChanged(0),
)
```

In this example, `AppNavigationBarItem` is used to create a navigation item with a home icon and label, which changes the active index when tapped.

## Additional Information

These widgets are part of the `truesight_flutter` library and provide a customizable navigation bar for Flutter applications.
