import 'package:flutter/material.dart'; // Import library Flutter untuk widget Material Design

// Widget utama untuk halaman Planner, menggunakan StatefulWidget agar state bisa berubah
class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key}); // Konstruktor dengan key opsional

  @override
  State<PlannerPage> createState() => _PlannerPageState(); // Membuat state untuk widget ini
}

// State dari PlannerPage, menyimpan data yang bisa berubah (seperti counter)
class _PlannerPageState extends State<PlannerPage> {
  int _counter = 0; // Variabel untuk menyimpan nilai counter

  @override
  Widget build(BuildContext context) { // Fungsi build untuk membangun tampilan UI
    return Center( // Widget Center untuk menengahkan child-nya
      child: Column( // Widget Column untuk menata widget secara vertikal
        mainAxisAlignment: MainAxisAlignment.center, // Menengahkan isi Column secara vertikal
        children: [
          const Text('Planner Page - State dipertahankan'), // Teks statis sebagai judul
          Text('Counter: $_counter'), // Menampilkan nilai counter saat ini
          ElevatedButton( // Tombol dengan style elevated
            onPressed: () => setState(() => _counter++), // Ketika tombol ditekan, counter bertambah dan UI di-refresh
            child: const Text('Tambah Counter'), // Teks pada tombol
          ),
        ],
      ),
    );
  }
}