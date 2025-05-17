import 'package:flutter/material.dart';

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Planner Page - State dipertahankan'),
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