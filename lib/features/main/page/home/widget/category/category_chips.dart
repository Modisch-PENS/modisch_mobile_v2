import 'package:flutter/material.dart';
import 'package:modisch/features/main/page/home/widget/category/category_chip.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectedIndex = 0;
  final List<String> categories = ['All', 'Short', 'Shirt', 'Shoes'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: index < categories.length - 1 ? 12 : 0),
            child: CategoryChip(
              label: categories[index],
              isSelected: selectedIndex == index,
              onSelected: () {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}