import 'package:hive_flutter/hive_flutter.dart';
import 'package:modisch/core/data/model/wardrobe_item.dart';

class HiveService {
  static const String wardrobeBoxName = 'clothing_items';
  
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(WardrobeItemAdapter());
    
    // Open boxes
    await Hive.openBox<WardrobeItem>(wardrobeBoxName);
  }

  static Box<WardrobeItem> get wardrobeBox => Hive.box<WardrobeItem>(wardrobeBoxName);
  
  static Future<void> close() async {
    await Hive.close();
  }
}