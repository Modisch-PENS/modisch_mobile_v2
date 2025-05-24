import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modisch/core/constants/colors.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/provider/wardrobe_provider.dart';

class ProfileHeader extends ConsumerWidget {
  final String userName;

  const ProfileHeader({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clothingItems = ref.watch(wardrobeItemsProvider);
    final clothesCount = clothingItems.length;
    final modelsCount = 0; // You can create a separate provider for models later

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 56),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [_buildAvatar(), const SizedBox(width: 16), _buildUserInfo(clothesCount, modelsCount)],
      ),
    );
  }

  Widget _buildAvatar() {
    return const CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey,
      child: Icon(Icons.person, size: 40, color: Colors.white),
    );
  }

  Widget _buildUserInfo(int clothesCount, int modelsCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          "Clothes : $clothesCount | Models : $modelsCount",
          style: const TextStyle(fontSize: 16, color: AppColors.fontActive),
        ),
      ],
    );
  }
}