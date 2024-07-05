// Create storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

abstract interface class SecureStorage {
  Future<String?> refreshToken();

  Future<void> saveTenantCredentials(String refreshToken);
}

class _SecureStorage implements SecureStorage {
  static const String _refreshTokenKey = 'refreshToken';

  @override
  Future<String?> refreshToken() {
    return _storage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> saveTenantCredentials(String refreshToken) async {
    await _storage.write(
      key: _refreshTokenKey,
      value: refreshToken,
    );
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }
}

final SecureStorage secureStorage = _SecureStorage();
