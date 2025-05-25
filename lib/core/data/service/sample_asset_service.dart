import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:modisch/core/data/model/sample_asset.dart';
import 'package:uuid/uuid.dart';

class SampleAssetsService {
  static const Uuid _uuid = Uuid();
  
  // Define sample assets based on actual folder structure
  static const List<SampleAsset> _sampleAssets = [
    // Dresses
    SampleAsset(
      id: 'dress_adidas',
      assetPath: 'assets/clothes/dress/dress_adidas.webp',
      category: 'Dress',
      name: 'Adidas Dress',
      description: 'Sporty Adidas dress',
    ),
    SampleAsset(
      id: 'dress_blackshort',
      assetPath: 'assets/clothes/dress/dress_blackshort.webp',
      category: 'Dress',
      name: 'Black Short Dress',
      description: 'Elegant black short dress',
    ),
    SampleAsset(
      id: 'dress_blue',
      assetPath: 'assets/clothes/dress/dress_blue.webp',
      category: 'Dress',
      name: 'Blue Dress',
      description: 'Beautiful blue dress',
    ),
    SampleAsset(
      id: 'dress_green',
      assetPath: 'assets/clothes/dress/dress_green.webp',
      category: 'Dress',
      name: 'Green Dress',
      description: 'Fresh green dress',
    ),
    SampleAsset(
      id: 'dress_longblack',
      assetPath: 'assets/clothes/dress/dress_longblack.webp',
      category: 'Dress',
      name: 'Long Black Dress',
      description: 'Elegant long black dress',
    ),
    SampleAsset(
      id: 'dress_red',
      assetPath: 'assets/clothes/dress/dress_red.webp',
      category: 'Dress',
      name: 'Red Dress',
      description: 'Stunning red dress',
    ),
    SampleAsset(
      id: 'dress_white',
      assetPath: 'assets/clothes/dress/dress_white.webp',
      category: 'Dress',
      name: 'White Dress',
      description: 'Classic white dress',
    ),

    // Pants
    SampleAsset(
      id: 'pants_beige',
      assetPath: 'assets/clothes/pants/pants_beige.webp',
      category: 'Pants',
      name: 'Beige Pants',
      description: 'Comfortable beige pants',
    ),
    SampleAsset(
      id: 'pants_blackjeans',
      assetPath: 'assets/clothes/pants/pants_blackjeans.webp',
      category: 'Pants',
      name: 'Black Jeans',
      description: 'Classic black jeans',
    ),
    SampleAsset(
      id: 'pants_blackloose',
      assetPath: 'assets/clothes/pants/pants_blackloose.webp',
      category: 'Pants',
      name: 'Black Loose Pants',
      description: 'Comfortable loose black pants',
    ),
    SampleAsset(
      id: 'pants_bluejeans',
      assetPath: 'assets/clothes/pants/pants_bluejeans.webp',
      category: 'Pants',
      name: 'Blue Jeans',
      description: 'Classic blue denim jeans',
    ),
    SampleAsset(
      id: 'pants_green',
      assetPath: 'assets/clothes/pants/pants_green.webp',
      category: 'Pants',
      name: 'Green Pants',
      description: 'Stylish green pants',
    ),
    SampleAsset(
      id: 'pants_grey',
      assetPath: 'assets/clothes/pants/pants_grey.webp',
      category: 'Pants',
      name: 'Grey Pants',
      description: 'Versatile grey pants',
    ),
    SampleAsset(
      id: 'pants_jeans',
      assetPath: 'assets/clothes/pants/pants_jeans.webp',
      category: 'Pants',
      name: 'Regular Jeans',
      description: 'Standard denim jeans',
    ),

    // Shirts
    SampleAsset(
      id: 'shirt_beige',
      assetPath: 'assets/clothes/shirt/shirt_beige.webp',
      category: 'Shirt',
      name: 'Beige Shirt',
      description: 'Neutral beige shirt',
    ),
    SampleAsset(
      id: 'shirt_black',
      assetPath: 'assets/clothes/shirt/shirt_black.webp',
      category: 'Shirt',
      name: 'Black Shirt',
      description: 'Classic black shirt',
    ),
    SampleAsset(
      id: 'shirt_blackplain',
      assetPath: 'assets/clothes/shirt/shirt_blackplain.webp',
      category: 'Shirt',
      name: 'Black Plain Shirt',
      description: 'Simple black plain shirt',
    ),
    SampleAsset(
      id: 'shirt_jaslab',
      assetPath: 'assets/clothes/shirt/shirt_jaslab.webp',
      category: 'Shirt',
      name: 'Jaslab Shirt',
      description: 'Branded Jaslab shirt',
    ),
    SampleAsset(
      id: 'shirt_lightblue',
      assetPath: 'assets/clothes/shirt/shirt_lightblue.webp',
      category: 'Shirt',
      name: 'Light Blue Shirt',
      description: 'Fresh light blue shirt',
    ),
    SampleAsset(
      id: 'shirt_plaid',
      assetPath: 'assets/clothes/shirt/shirt_plaid.webp',
      category: 'Shirt',
      name: 'Plaid Shirt',
      description: 'Stylish plaid pattern shirt',
    ),
    SampleAsset(
      id: 'shirt_white',
      assetPath: 'assets/clothes/shirt/shirt_white.webp',
      category: 'Shirt',
      name: 'White Shirt',
      description: 'Clean white shirt',
    ),
    SampleAsset(
      id: 'shirt_whiteplain',
      assetPath: 'assets/clothes/shirt/shirt_whiteplain.webp',
      category: 'Shirt',
      name: 'White Plain Shirt',
      description: 'Simple white plain shirt',
    ),

    // Shoes
    SampleAsset(
      id: 'shoes_asics',
      assetPath: 'assets/clothes/shoes/shoes_asics.webp',
      category: 'Shoes',
      name: 'Asics Sneakers',
      description: 'Athletic Asics sneakers',
    ),
    SampleAsset(
      id: 'shoes_black',
      assetPath: 'assets/clothes/shoes/shoes_black.webp',
      category: 'Shoes',
      name: 'Black Shoes',
      description: 'Classic black dress shoes',
    ),
    SampleAsset(
      id: 'shoes_boots',
      assetPath: 'assets/clothes/shoes/shoes_boots.webp',
      category: 'Shoes',
      name: 'Boots',
      description: 'Sturdy leather boots',
    ),
    SampleAsset(
      id: 'shoes_converse',
      assetPath: 'assets/clothes/shoes/shoes_converse.webp',
      category: 'Shoes',
      name: 'Converse Sneakers',
      description: 'Classic Converse sneakers',
    ),
    SampleAsset(
      id: 'shoes_loafers',
      assetPath: 'assets/clothes/shoes/shoes_loafers.webp',
      category: 'Shoes',
      name: 'Loafers',
      description: 'Comfortable loafers',
    ),
    SampleAsset(
      id: 'shoes_onitsuka',
      assetPath: 'assets/clothes/shoes/shoes_onitsuka.webp',
      category: 'Shoes',
      name: 'Onitsuka Tiger',
      description: 'Stylish Onitsuka Tiger sneakers',
    ),
    SampleAsset(
      id: 'shoes_white',
      assetPath: 'assets/clothes/shoes/shoes_white.webp',
      category: 'Shoes',
      name: 'White Shoes',
      description: 'Clean white sneakers',
    ),
  ];

  static List<SampleAsset> getAllSampleAssets() {
    return List.from(_sampleAssets);
  }

  static List<SampleAsset> getSampleAssetsByCategory(String category) {
    if (category.toLowerCase() == 'all') {
      return getAllSampleAssets();
    }
    return _sampleAssets
        .where((asset) => asset.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  static SampleAsset? getSampleAssetById(String id) {
    try {
      return _sampleAssets.firstWhere((asset) => asset.id == id);
    } catch (e) {
      return null;
    }
  }

  // Copy asset from bundle to local storage
  static Future<String> copyAssetToLocal(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/images');
      
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      final fileName = '${_uuid.v4()}.png';
      final localPath = '${imagesDir.path}/$fileName';
      
      final file = File(localPath);
      await file.writeAsBytes(byteData.buffer.asUint8List());
      
      return localPath;
    } catch (e) {
      throw Exception('Failed to copy asset: $e');
    }
  }

  // Check if asset exists in bundle
  static Future<bool> assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }
}