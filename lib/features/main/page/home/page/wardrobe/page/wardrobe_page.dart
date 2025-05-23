import 'package:flutter/material.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/widget/wardrobe_item_card.dart';
import 'package:modisch/features/main/page/home/widget/category/category_chips.dart';

class WardrobePage extends StatelessWidget {
  const WardrobePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          CategoryChips(),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 1, // Contoh dengan 1 item
              itemBuilder: (context, index) {
                return const WardrobeItemCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
