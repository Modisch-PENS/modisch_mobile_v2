import 'package:hive/hive.dart';

part 'wardrobe_item.g.dart';

@HiveType(typeId: 0)
class WardrobeItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String imagePath;

  @HiveField(2)
  String category;

  @HiveField(3)
  String? name;

  @HiveField(4)
  String? description;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  WardrobeItem({
    required this.id,
    required this.imagePath,
    required this.category,
    this.name,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  WardrobeItem copyWith({
    String? id,
    String? imagePath,
    String? category,
    String? name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WardrobeItem(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum WardrobeCategory {
  all('All'),
  dress('Dress'),
  pants('Pants'),
  shirt('Shirt'),
  shoes('Shoes');

  const WardrobeCategory(this.displayName);
  final String displayName;
}