import 'package:modisch/core/data/model/wardrobe_item.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/repository/wardrobe_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wardrobe_provider.g.dart';

@riverpod
WardrobeRepository wardrobeRepository(WardrobeRepositoryRef ref) {
  return WardrobeRepository();
}

@riverpod
class WardrobeItems extends _$WardrobeItems {
  @override
  List<WardrobeItem> build() {
    final repository = ref.watch(wardrobeRepositoryProvider);
    return repository.getAllWardrobeItems();
  }

  Future<void> addItem({
    required String imagePath,
    required String category,
    String? name,
    String? description,
  }) async {
    final repository = ref.read(wardrobeRepositoryProvider);
    await repository.addWardrobeItem(
      imagePath: imagePath,
      category: category,
      name: name,
      description: description,
    );
    
    // Refresh the state
    state = repository.getAllWardrobeItems();
  }

  Future<void> updateItem(WardrobeItem item) async {
    final repository = ref.read(wardrobeRepositoryProvider);
    await repository.updateWardrobeItem(item);
    
    // Refresh the state
    state = repository.getAllWardrobeItems();
  }

  Future<void> deleteItem(String id) async {
    final repository = ref.read(wardrobeRepositoryProvider);
    await repository.deleteWardrobeItem(id);
    
    // Refresh the state
    state = repository.getAllWardrobeItems();
  }

  void refresh() {
    final repository = ref.read(wardrobeRepositoryProvider);
    state = repository.getAllWardrobeItems();
  }
}

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String build() => 'All';

  void setCategory(String category) {
    state = category;
  }
}

@riverpod
List<WardrobeItem> filteredWardrobeItems(FilteredWardrobeItemsRef ref) {
  final items = ref.watch(wardrobeItemsProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final repository = ref.watch(wardrobeRepositoryProvider);
  
  return repository.getWardrobeItemsByCategory(selectedCategory);
}