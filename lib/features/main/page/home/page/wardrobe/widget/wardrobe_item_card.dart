import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modisch/core/constants/colors.dart';
import 'package:modisch/core/constants/spacing.dart';
import 'package:modisch/core/data/model/wardrobe_item.dart';
import 'package:modisch/core/data/service/image_service.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/provider/wardrobe_provider.dart';

class WardrobeItemCard extends ConsumerWidget {
  final WardrobeItem? item;

  const WardrobeItemCard({super.key, this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _WardrobeItemCard(item: item!);
  }
}

class _WardrobeItemCard extends ConsumerWidget {
  final WardrobeItem item;

  const _WardrobeItemCard({required this.item});

  void _showItemDetails(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ItemDetailsBottomSheet(item: item),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showItemDetails(context, ref),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child:
                      File(item.imagePath).existsSync()
                          ? Image.file(
                            File(item.imagePath),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                          : Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              size: 48,
                              color: Colors.grey,
                            ),
                          ),
                ),
              ),
            ),
            // Item details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? item.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(4),
                  Text(
                    item.category,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemDetailsBottomSheet extends ConsumerStatefulWidget {
  final WardrobeItem item;

  const _ItemDetailsBottomSheet({required this.item});

  @override
  ConsumerState<_ItemDetailsBottomSheet> createState() =>
      _ItemDetailsBottomSheetState();
}

class _ItemDetailsBottomSheetState
    extends ConsumerState<_ItemDetailsBottomSheet> {
  bool _isEditingName = false;
  bool _isEditingDescription = false;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.item.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _deleteItem(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Delete Item',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Are you sure you want to delete this item? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Close bottom sheet

                  // Delete the image file
                  await ImageService.deleteImage(widget.item.imagePath);

                  // Delete from database
                  await ref
                      .read(wardrobeItemsProvider.notifier)
                      .deleteItem(widget.item.id);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Item deleted successfully'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _saveName() async {
    final updatedItem = widget.item.copyWith(
      name:
          _nameController.text.trim().isEmpty
              ? null
              : _nameController.text.trim(),
    );

    await ref.read(wardrobeItemsProvider.notifier).updateItem(updatedItem);

    setState(() {
      _isEditingName = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Name updated successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  Future<void> _saveDescription() async {
    final updatedItem = widget.item.copyWith(
      description:
          _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
    );

    await ref.read(wardrobeItemsProvider.notifier).updateItem(updatedItem);

    setState(() {
      _isEditingDescription = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Description updated successfully'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _cancelNameEdit() {
    _nameController.text = widget.item.name ?? '';
    setState(() {
      _isEditingName = false;
    });
  }

  void _cancelDescriptionEdit() {
    _descriptionController.text = widget.item.description ?? '';
    setState(() {
      _isEditingDescription = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // App bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                    const Text(
                      'Item Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _deleteItem(context, ref),
                      icon: const Icon(Icons.delete_outline),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.red[50],
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        width: double.infinity,
                        height: 300,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:
                              File(widget.item.imagePath).existsSync()
                                  ? Image.file(
                                    File(widget.item.imagePath),
                                    fit: BoxFit.cover,
                                  )
                                  : Container(
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                  ),
                        ),
                      ),

                      // Item name (editable)
                      Row(
                        children: [
                          Expanded(
                            child:
                                _isEditingName
                                    ? TextField(
                                      controller: _nameController,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Item name',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(
                                          12,
                                        ),
                                      ),
                                      autofocus: true,
                                      onSubmitted: (_) => _saveName(),
                                    )
                                    : Text(
                                      _nameController.text.isEmpty
                                          ? 'Unnamed Item'
                                          : _nameController.text,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                      ),
                                    ),
                          ),
                          if (_isEditingName) ...[
                            IconButton(
                              onPressed: _saveName,
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              tooltip: 'Save',
                            ),
                            IconButton(
                              onPressed: _cancelNameEdit,
                              icon: const Icon(Icons.close, color: Colors.red),
                              tooltip: 'Cancel',
                            ),
                          ] else
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isEditingName = true;
                                });
                              },
                              icon: const Icon(Icons.edit, size: 20),
                              tooltip: 'Edit name',
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                padding: const EdgeInsets.all(8),
                              ),
                            ),
                        ],
                      ),

                      verticalSpace(12),

                      // Category badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.blue[200]!,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.item.category,
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      verticalSpace(24),

                      // Description (editable)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              if (_isEditingDescription) ...[
                                IconButton(
                                  onPressed: _saveDescription,
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  tooltip: 'Save',
                                ),
                                IconButton(
                                  onPressed: _cancelDescriptionEdit,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  tooltip: 'Cancel',
                                ),
                              ] else
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEditingDescription = true;
                                    });
                                  },
                                  icon: const Icon(Icons.edit, size: 20),
                                  tooltip: 'Edit description',
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.grey[100],
                                    padding: const EdgeInsets.all(8),
                                  ),
                                ),
                            ],
                          ),
                          verticalSpace(8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child:
                                _isEditingDescription
                                    ? TextField(
                                      controller: _descriptionController,
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                        hintText: 'Add a description...',
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        height: 1.5,
                                      ),
                                      autofocus: true,
                                    )
                                    : Text(
                                      _descriptionController.text.isEmpty
                                          ? 'No description added'
                                          : _descriptionController.text,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            _descriptionController.text.isEmpty
                                                ? Colors.grey[500]
                                                : Colors.grey[700],
                                        height: 1.5,
                                        fontStyle:
                                            _descriptionController.text.isEmpty
                                                ? FontStyle.italic
                                                : FontStyle.normal,
                                      ),
                                    ),
                          ),
                        ],
                      ),

                      verticalSpace(24),

                      // Metadata section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Item Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            verticalSpace(12),
                            _buildInfoRow(
                              icon: Icons.calendar_today,
                              label: 'Added on',
                              value:
                                  '${widget.item.createdAt.day}/${widget.item.createdAt.month}/${widget.item.createdAt.year}',
                            ),
                            verticalSpace(8),
                            _buildInfoRow(
                              icon: Icons.update,
                              label: 'Last updated',
                              value:
                                  '${widget.item.updatedAt.day}/${widget.item.updatedAt.month}/${widget.item.updatedAt.year}',
                            ),
                          ],
                        ),
                      ),

                      verticalSpace(32), // Bottom padding
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        horizontalSpace(8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
