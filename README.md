# truesight_flutter

A new Flutter project.

## Getting Started

To install this package:

```bash
flutter pub add truesight_flutter go_router truesight_core dio dio_cookie_manager
```

## Usage

- Define a `routes.dart` file:

```dart
void registerRoutes() {
    registerRoute(HomePage, "/home");
    registerRoute(ProfilePage, "/profile");
    // Register all routes here
}
```

- Call the `registerRoutes()` method in `main()`:

```dart
void main() {
    WidgetFlutterBinding.ensureInitialized();
    //
    registerRoutes();
    //
    runApp(MainApp());
}
```

- To route to a page:

```dart
GoRouter.of(context).push(getRoutingKey(
    HomePage,
    pathParameters: {'id': 1},
    queryParameters: {'file': 'test.docx'}
));
```

## Additional information

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

