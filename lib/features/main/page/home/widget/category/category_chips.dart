import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modisch/core/data/model/wardrobe_item.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/provider/wardrobe_provider.dart';
import 'package:modisch/features/main/page/home/widget/category/category_chip.dart';

class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: WardrobeCategory.values.length,
        itemBuilder: (context, index) {
          final category = WardrobeCategory.values[index];
          return Padding(
            padding: EdgeInsets.only(right: index < WardrobeCategory.values.length - 1 ? 12 : 0),
            child: CategoryChip(
              label: category.displayName,
              isSelected: selectedCategory == category.displayName,
              onSelected: () {
                ref.read(selectedCategoryProvider.notifier).setCategory(category.displayName);
              },
            ),
          );
        },
      ),
    );
  }
}