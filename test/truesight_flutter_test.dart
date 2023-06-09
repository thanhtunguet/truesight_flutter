import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

import 'models/user.dart';
import 'models/user_filter.dart';
import 'truesight_flutter_test.reflectable.dart';

void main() {
  initializeReflectable();
  test('deserialization', () {
    var json = {
      'id': 1,
      'username': 'TungPT',
      'email': 'tungpt@truesight.asia',
      'birthday': '1997-11-01T01:59:00+0700',
      'manager': {
        'id': 2,
        'username': 'ThangLD',
        'email': 'thangld@truesight.asia',
        'birthday': '1991-05-10T01:59:00+0700',
      },
      'members': [
        {
          'id': 3,
          'username': 'TienTV',
          'email': 'tientv@truesight.asia',
          'birthday': '1997-05-10T01:59:00+0700',
        }
      ]
    };
    var user = User();
    user.fromJSON(json);
    expect(user.username, 'TungPT');
    expect(user.manager.runtimeType, User);
    expect(user.members, isA<DataList<User>>());

    if (kDebugMode) {
      print(user.members);
    }
  });

  test('json serialization', () {
    User tungpt = User();
    tungpt.username = 'TungPT';
    tungpt.email = 'tungpt@truesight.asia';
    tungpt.birthday = DateTime(1997, 01, 11);
    tungpt.id = 1;

    var jsonString = jsonEncode(tungpt.toJSON());
    expect(
      jsonString,
      '{"id":1,"username":"TungPT","email":"tungpt@truesight.asia","birthday":"1997-01-11T00:00:00.000","age":0,"manager":null,"members":[]}',
    );

    User thangld = User();
    thangld.id = 2;
    thangld.username = 'thangld';
    thangld.email = 'thangld@truesight.asia';
    thangld.birthday = DateTime(1991, 05, 10);
    thangld.members.add(tungpt);
    tungpt.manager = thangld;
  });

  test('data filter', () {
    UserFilter userFilter = UserFilter();
    userFilter.username.equal = "TungPT";
    expect(userFilter.username.equal, 'TungPT');
  });
}
