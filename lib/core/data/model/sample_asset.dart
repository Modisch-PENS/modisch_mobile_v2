class SampleAsset {
  final String id;
  final String assetPath;
  final String category;
  final String name;
  final String? description;

  const SampleAsset({
    required this.id,
    required this.assetPath,
    required this.category,
    required this.name,
    this.description,
  });

  SampleAsset copyWith({
    String? id,
    String? assetPath,
    String? category,
    String? name,
    String? description,
  }) {
    return SampleAsset(
      id: id ?? this.id,
      assetPath: assetPath ?? this.assetPath,
      category: category ?? this.category,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}