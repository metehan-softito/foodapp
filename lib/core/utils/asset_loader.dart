import 'dart:io';

class AssetLoader {
  static Future<List<String>> getBurgerPatties() async {
    final directory = Directory('assets/images/ingredients/burger_patty');
    final files = directory.listSync();
    return files.whereType<File>().map((f) => f.path).toList();
  }
}
