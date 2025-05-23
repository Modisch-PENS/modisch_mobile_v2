import 'package:flutter/material.dart';

class AddOutfitPage extends StatefulWidget {
  const AddOutfitPage({super.key});

  @override
  State<AddOutfitPage> createState() => _AddOutfitPageState();
}

class _AddOutfitPageState extends State<AddOutfitPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Outfit Page - State dipertahankan'),
          Text('Counter: $_counter'),
          ElevatedButton(
            onPressed: () => setState(() => _counter++),
            child: const Text('Tambah Counter'),
          ),
        ],
      ),
    );
  }
}