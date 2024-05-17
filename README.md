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

_Thư viện lõi cho các ứng dụng Flutter của TrueSight team._

## Features

- JSON Serialization thuận tiện với cơ chế auto mapper
- Xây dựng bộ filter riêng khi tích hợp với backend
- Quản lý HTTP request với HTTPRepository dựng sẵn
- Tích hợp `go_router` làm cơ chế routing mặc định
- Một số tiện ích khác

## Getting started

Để cài đặt package này, chạy:

```sh
flutter pub add truesight_flutter go_router intl
```

## Usage

### JSON Serialization

Thư viện cung cấp các class sau:

`DataModel`: Đại diện cho một Entity trong ứng dụng, cũng thường được ánh xạ với một bảng trong Cơ sở dữ liệu của backend.

`DataFilter`: Bộ Filter cho một `DataModel` cụ thể.

Quy ước: mỗi `DataModel` nên có một `DataFilter` đi kèm.

Các entity và filter trong ứng dụng sẽ `extends` 2 class này.

Để định nghĩa một class mới, ta xét ví dụ sau với class `AppUser`:

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

Trong đó:

- getter `fields`: là các trường JSON sẽ được auto-map từ JSON khi lấy dữ liệu từ backend
- Các trường dữ liệu JSON được đại diện bởi các class sau:

| Class         | Dart data type    |
|---------------|-------------------|
| `JsonDate`    | `DateTime`        |
| `JsonBoolean` | `bool`            |
| `JsonString`  | `String`          |
| `JsonInteger` | `int`             |
| `JsonDouble`  | `double`          |
| `JsonNumber`  | `num`             |
| `JsonObject`  | `DataModel`       |
| `JsonList`    | `List<DataModel>` |

Các class `JsonXYZ` kế thừa từ `JsonField`.

#### Map dữ liệu từ JSON

```dart
final json = await requestFromAPI();
AppUser user = AppUser();
user.fromJSON(json);
```

#### Chuyển đổi thành JSON

```dart
AppUser user = AppUser();
user.toJSON(); // Returns the JSON representation of the user, typically a Dart Map object.
user.toString(); // Returns the JSON representation of the user, in Dart String type.
```

### Advanced Filters

Tương tự các class JSON, thư viện định nghĩa các kiểu dữ liệu `FilterField` như sau:

| Class          | Dart data type | Json data type |
|----------------|----------------|----------------|
| `StringFilter` | `String`       | `JsonString`   |
| `DateFilter`   | `DateTime`     | `JsonDate`     |
| `GuidFilter`   | `String`       | `JsonString`   |
| `IdFilter`     | `int`          | `JsonInteger`  |
| `IntFilter`    | `int`          | `JsonInteger`  |
| `DoubleFilter` | `double`       | `JsonDouble`   |
| `NumberFilter` | `num`          | `JsonNumber`   |

### HTTP Request

Repository là class thực hiện các nhiệm vụ gọi đến API của backend để lấy dữ liệu.

Mỗi `HttpRepository` class có thể đại diện cho một tập API tương ứng với một nghiệp vụ cụ thể. Ví dụ: đăng nhập người dùng (`UserRepository`), quản lý sản phẩm (`ProductRepository`)

Class `HttpRepository` có thể được sử dụng kèm `@singleton` từ package `injectable` kết hợp với `get_it` để phục vụ Dependency injection.

Mỗi method trong `HttpRepository` tương ứng với một API cụ thể.

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

### Extensions

## Additional information

This package is under development. Feel free to create an issue.
