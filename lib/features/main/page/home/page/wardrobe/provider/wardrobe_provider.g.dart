// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wardrobe_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wardrobeRepositoryHash() =>
    r'1accc5ead19bce2f9642d3fb2bd2596bae211bf1';

/// See also [wardrobeRepository].
@ProviderFor(wardrobeRepository)
final wardrobeRepositoryProvider =
    AutoDisposeProvider<WardrobeRepository>.internal(
  wardrobeRepository,
  name: r'wardrobeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wardrobeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WardrobeRepositoryRef = AutoDisposeProviderRef<WardrobeRepository>;
String _$filteredWardrobeItemsHash() =>
    r'bf364413d8d063474039689356d50a2480d5137f';

/// See also [filteredWardrobeItems].
@ProviderFor(filteredWardrobeItems)
final filteredWardrobeItemsProvider =
    AutoDisposeProvider<List<WardrobeItem>>.internal(
  filteredWardrobeItems,
  name: r'filteredWardrobeItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredWardrobeItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredWardrobeItemsRef = AutoDisposeProviderRef<List<WardrobeItem>>;
String _$wardrobeItemsHash() => r'155e4d3029a6d7d89717b66565960d5e6bde023d';

/// See also [WardrobeItems].
@ProviderFor(WardrobeItems)
final wardrobeItemsProvider =
    AutoDisposeNotifierProvider<WardrobeItems, List<WardrobeItem>>.internal(
  WardrobeItems.new,
  name: r'wardrobeItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wardrobeItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WardrobeItems = AutoDisposeNotifier<List<WardrobeItem>>;
String _$selectedCategoryHash() => r'1d06cb3e38d4f4e5cfb0f45fc3e662b37b6b2e30';

/// See also [SelectedCategory].
@ProviderFor(SelectedCategory)
final selectedCategoryProvider =
    AutoDisposeNotifierProvider<SelectedCategory, String>.internal(
  SelectedCategory.new,
  name: r'selectedCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCategory = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
