import 'package:hive/hive.dart';
import 'package:modisch/core/data/model/wardrobe_item.dart';
import 'package:modisch/core/data/service/hive_service.dart';
import 'package:uuid/uuid.dart';

class WardrobeRepository {
  static const Uuid _uuid = Uuid();
  
  Box<WardrobeItem> get _box => HiveService.wardrobeBox;

  Future<void> addWardrobeItem({
    required String imagePath,
    required String category,
    String? name,
    String? description,
  }) async {
    final now = DateTime.now();
    final item = WardrobeItem(
      id: _uuid.v4(),
      imagePath: imagePath,
      category: category,
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    );

    await _box.put(item.id, item);
  }

  Future<void> updateWardrobeItem(WardrobeItem item) async {
    final updatedItem = item.copyWith(updatedAt: DateTime.now());
    await _box.put(updatedItem.id, updatedItem);
  }

  Future<void> deleteWardrobeItem(String id) async {
    await _box.delete(id);
  }

  List<WardrobeItem> getAllWardrobeItems() {
    return _box.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<WardrobeItem> getWardrobeItemsByCategory(String category) {
    if (category.toLowerCase() == 'all') {
      return getAllWardrobeItems();
    }
    
    return _box.values
        .where((item) => item.category.toLowerCase() == category.toLowerCase())
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  WardrobeItem? getWardrobeItemById(String id) {
    return _box.get(id);
  }

  Stream<List<WardrobeItem>> watchAllWardrobeItems() {
    return _box.watch().map((_) => getAllWardrobeItems());
  }

  Stream<List<WardrobeItem>> watchWardrobeItemsByCategory(String category) {
    return _box.watch().map((_) => getWardrobeItemsByCategory(category));
  }
}