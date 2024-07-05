// Create storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

class SavedAccount {
  final String? username;

  final String? password;

  const SavedAccount(
    this.username,
    this.password,
  );
}

abstract interface class SecureStorage {
  Future<SavedAccount> getSavedAccount();

  Future<void> setSavedAccount(String username, String password);

  Future<void> saveTenantCredentials(String refreshToken);

  Future<void> deleteSavedAccount();
}

class _SecureStorage implements SecureStorage {
  static const usernameKey = 'username';

  static const passwordKey = 'password';

  @override
  Future<SavedAccount> getSavedAccount() async {
    final username = await _storage.read(key: usernameKey);
    final password = await _storage.read(key: passwordKey);
    return SavedAccount(username, password);
  }

  @override
  Future<void> setSavedAccount(String username, String password) async {
    await _storage.write(key: usernameKey, value: username);
    await _storage.write(key: passwordKey, value: password);
  }

  @override
  Future<void> deleteSavedAccount() async {
    await _storage.delete(key: usernameKey);
    await _storage.delete(key: passwordKey);
  }

  @override
  Future<void> saveTenantCredentials(String refreshToken) async {
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }
}

final SecureStorage secureStorage = _SecureStorage();
