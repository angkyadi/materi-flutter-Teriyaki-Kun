import 'package:flutter/material.dart';

class DataNapi extends StatefulWidget {
  const DataNapi({super.key});

  @override
  State<DataNapi> createState() => _DataNapiState();
}

class _DataNapiState extends State<DataNapi> {
  final _namaController = TextEditingController();
  final _jkController = TextEditingController();
  final _ageController = TextEditingController();
  final _crimeController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _jkController.dispose();
    _ageController.dispose();
    _crimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Napi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _jkController,
              decoration: const InputDecoration(
                labelText: 'Jenis Kelamin',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Usia',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _crimeController,
              decoration: const InputDecoration(
                labelText: 'Kasus',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}