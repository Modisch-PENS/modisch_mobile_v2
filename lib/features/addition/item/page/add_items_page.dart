import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modisch/core/constants/colors.dart';
import 'package:modisch/core/constants/spacing.dart';
import 'package:modisch/core/data/model/sample_asset.dart';
import 'package:modisch/core/data/model/wardrobe_item.dart';
import 'package:modisch/core/data/service/image_service.dart';
import 'package:modisch/core/data/service/sample_asset_service.dart';
import 'package:modisch/core/router/route_constants.dart';
import 'package:modisch/features/main/page/home/page/wardrobe/provider/wardrobe_provider.dart';

class AddItemsPage extends ConsumerStatefulWidget {
  const AddItemsPage({super.key});

  @override
  ConsumerState<AddItemsPage> createState() => _AddItemsPageState();
}

class _AddItemsPageState extends ConsumerState<AddItemsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  Set<String> _selectedSampleAssets = {};
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // agar rebuild ketika tab berubah
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromCamera() async {
    setState(() => _isLoading = true);

    try {
      final imagePath = await ImageService.pickImageFromCamera();
      if (imagePath != null && mounted) {
        context.goNamed(
          RouteConstants.confirmItem,
          extra: {'imagePath': imagePath, 'isFromSample': false},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImageFromGallery() async {
    setState(() => _isLoading = true);

    try {
      final imagePath = await ImageService.pickImageFromGallery();
      if (imagePath != null && mounted) {
        context.go(
          RouteConstants.confirmItemPath,
          extra: {'imagePath': imagePath, 'isFromSample': false},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _toggleSampleAssetSelection(String assetId) {
    setState(() {
      if (_selectedSampleAssets.contains(assetId)) {
        _selectedSampleAssets.remove(assetId);
      } else {
        _selectedSampleAssets.add(assetId);
      }
    });
  }

  Future<void> _saveSampleAssets() async {
    if (_selectedSampleAssets.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      for (final assetId in _selectedSampleAssets) {
        final asset = SampleAssetsService.getSampleAssetById(assetId);
        if (asset != null) {
          // Copy asset to local storage
          final localPath = await SampleAssetsService.copyAssetToLocal(
            asset.assetPath,
          );

          // Add to wardrobe
          await ref
              .read(wardrobeItemsProvider.notifier)
              .addItem(
                imagePath: localPath,
                category: asset.category,
                name: asset.name,
                description: asset.description,
              );
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_selectedSampleAssets.length} items added successfully!',
            ),
          ),
        );
        context.go(RouteConstants.homePath);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving items: $e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Icon _getTabIcon({
    required int tabIndex,
    required IconData filled,
    required IconData outlined,
  }) {
    final isSelected = _tabController.index == tabIndex;
    return Icon(
      isSelected ? filled : outlined,
      color: isSelected ? AppColors.fontActive : AppColors.disabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    final existingItems = ref.watch(wardrobeItemsProvider);
    final existingAssetIds =
        existingItems
            .where((item) => item.name != null)
            .map((item) => item.name!)
            .toSet();

    // Filter out already added sample assets
    final availableSampleAssets =
        SampleAssetsService.getAllSampleAssets()
            .where((asset) => !existingAssetIds.contains(asset.name))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Items'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go(RouteConstants.homePath),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: _getTabIcon(
                tabIndex: 0,
                filled: Icons.photo_camera,
                outlined: Icons.photo_camera_outlined,
              ),
              text: 'Camera Roll',
            ),
            Tab(
              icon: _getTabIcon(
                tabIndex: 1,
                filled: Icons.folder,
                outlined: Icons.folder_outlined,
              ),
              text: 'Sample',
            ),
          ],

          labelColor: AppColors.fontActive,
          dividerColor: Colors.transparent,
          unselectedLabelColor: AppColors.disabled,
          indicatorColor: AppColors.secondaryVariant,
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              // Camera/Gallery Tab
              _buildCameraTab(),
              // Sample Assets Tab
              _buildSampleTab(availableSampleAssets),
            ],
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),

          // Save button for sample assets
          if (_selectedSampleAssets.isNotEmpty)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveSampleAssets,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save ${_selectedSampleAssets.length} Item${_selectedSampleAssets.length > 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCameraTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Camera Section
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.secondaryVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _isLoading ? null : _pickImageFromCamera,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 48, color: AppColors.primary),
                    SizedBox(height: 8),
                    Text(
                      'Camera',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          verticalSpace(20),

          // Gallery Section Header
          Row(
            children: [
              const Text(
                'Gallery',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              TextButton(
                onPressed: _pickImageFromGallery,
                child: const Text('Browse', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),

          verticalSpace(12),

          // Gallery Grid (placeholder)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  verticalSpace(16),
                  Text(
                    'No photos available',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  verticalSpace(8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryVariant,
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _pickImageFromGallery,
                    child: const Text('Select from Gallery'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleTab(List<SampleAsset> availableSampleAssets) {
    // Filter assets by selected category
    final filteredAssets =
        _selectedCategory == 'All'
            ? availableSampleAssets
            : availableSampleAssets
                .where((asset) => asset.category == _selectedCategory)
                .toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add your basic',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          verticalSpace(16),

          // Category chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  WardrobeCategory.values.map((category) {
                    final isSelected =
                        _selectedCategory == category.displayName;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category.displayName;
                            _selectedSampleAssets
                                .clear(); // Clear selections when switching categories
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColors.secondaryVariant
                                    : AppColors.background,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.secondaryVariant
                                      : Colors.grey[300]!,
                            ),
                          ),
                          child: Text(
                            category.displayName,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? AppColors.primary
                                      : AppColors.fontActive,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          verticalSpace(20),

          // Sample assets grid
          Expanded(
            child:
                filteredAssets.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.checkroom_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          verticalSpace(16),
                          Text(
                            _selectedCategory == 'All'
                                ? 'All sample items have been added'
                                : 'No ${_selectedCategory.toLowerCase()} items available',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                    : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                      itemCount: filteredAssets.length,
                      itemBuilder: (context, index) {
                        final asset = filteredAssets[index];
                        final isSelected = _selectedSampleAssets.contains(
                          asset.id,
                        );

                        return GestureDetector(
                          onTap: () => _toggleSampleAssetSelection(asset.id),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? AppColors.secondaryVariant
                                            : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(12),
                                              ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(12),
                                              ),
                                          child: Image.asset(
                                            asset.assetPath,
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Container(
                                                color: AppColors.background,
                                                child: const Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.broken_image,
                                                        size: 32,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        'Image not found',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            asset.name,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          verticalSpace(2),
                                          Text(
                                            asset.category,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (isSelected)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryVariant,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: AppColors.primary,
                                      size: 16,
                                    ),
                                  ),
                                ),

                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? AppColors.error
                                            : AppColors.disabled,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    isSelected ? Icons.remove : Icons.add,
                                    color: AppColors.primary,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
