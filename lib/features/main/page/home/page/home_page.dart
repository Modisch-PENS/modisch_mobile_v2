import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<File> _clothesList = [];
  final String removeBgApiKey = 'mj4GnZgxYuSurxN6D8Z432N3';

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      File? bgRemovedFile = await _removeBackground(file);

      if (bgRemovedFile != null) {
        setState(() {
          _clothesList.add(bgRemovedFile);
        });
      }
    }
  }

  Future<File?> _removeBackground(File imageFile) async {
    final url = Uri.parse('https://api.remove.bg/v1.0/removebg');
    final request = http.MultipartRequest('POST', url)
      ..headers['X-Api-Key'] = removeBgApiKey
      ..files.add(await http.MultipartFile.fromPath('image_file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final bytes = await response.stream.toBytes();
      final newPath = '${imageFile.parent.path}/bg_removed_${imageFile.path.split('/').last}';
      final newFile = File(newPath);
      await newFile.writeAsBytes(bytes);
      return newFile;
    } else {
      debugPrint('Failed to remove background: ${response.statusCode}');
      return null;
    }
  }

  void _showImageSourceMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Cam'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gal'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('api remove bg online ver 1 - nyoba api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _clothesList.isEmpty
            ? const Center(child: Text('Bajumu gada'))
            : ListView.builder(
                itemCount: _clothesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: ListTile(
                      leading: Image.file(
                        _clothesList[index],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImageSourceMenu,
        child: const Icon(Icons.add),
      ),
    );
  }
}
