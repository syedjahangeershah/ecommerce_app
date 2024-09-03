import 'package:get_storage/get_storage.dart';

class StorageService {
  StorageService._singleton();

  static final StorageService _instance = StorageService._singleton();

  factory StorageService() {
    return _instance;
  }

  final _storage = GetStorage();

  void writeData(String key, dynamic value) {
    _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  void removeData(String key) {
    _storage.remove(key);
  }

  void clearStorage() {
    _storage.erase();
  }
}
