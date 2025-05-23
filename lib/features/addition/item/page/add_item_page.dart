import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Add Item Page - State dipertahankan'),
            Text('Counter: $_counter'),
            ElevatedButton(
              onPressed: () => setState(() => _counter++),
              child: const Text('Tambah Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
