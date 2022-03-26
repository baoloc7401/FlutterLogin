import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    return await _storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> deleteSecureData(String key) async {
    return await _storage.delete(key: key);
  }

  Future<bool> checkContainsKey(String key) async {
    return await _storage.containsKey(key: key);
  }
}
