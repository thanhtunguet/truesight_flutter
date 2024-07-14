import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as path;
import 'package:truesight_flutter/truesight_flutter.dart';

part 'base_repository.dart';
part 'bin_repository.dart';
part 'http_repository.dart';
part 'interceptors.dart';
part 'portal_authentication_repository.dart';
part 'portal_profile_repository.dart';
part 'token_repository.dart';
part 'utils_notification_repository.dart';
