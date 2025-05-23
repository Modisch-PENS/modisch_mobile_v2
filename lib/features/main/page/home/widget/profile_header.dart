import 'package:flutter/material.dart';
import 'package:modisch/core/constants/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final int clothesCount;
  final int modelsCount;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.clothesCount,
    required this.modelsCount,
  });

  @override
  Widget build(BuildContext context) {
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
        children: [_buildAvatar(), const SizedBox(width: 16), _buildUserInfo()],
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

  Widget _buildUserInfo() {
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
