import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();
  static const Uuid _uuid = Uuid();

  static Future<bool> requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    final photosStatus = await Permission.photos.request();
    
    return cameraStatus == PermissionStatus.granted &&
           photosStatus == PermissionStatus.granted;
  }

  static Future<String?> pickImageFromCamera() async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('Camera permission denied');
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return await _saveImageLocally(image);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to capture image: $e');
    }
  }

  static Future<String?> pickImageFromGallery() async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('Gallery permission denied');
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        return await _saveImageLocally(image);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  static Future<String> _saveImageLocally(XFile image) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${appDir.path}/images');
      
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      final fileName = '${_uuid.v4()}.jpg';
      final localPath = '${imagesDir.path}/$fileName';
      
      await image.saveTo(localPath);
      return localPath;
    } catch (e) {
      throw Exception('Failed to save image: $e');
    }
  }

  static Future<bool> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}