import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class datanapi extends StatefulWidget {
  @override
  _datanapi createState() => _datanapi();
}

class _datanapi extends State<datanapi> {
  final _nama = TextEditingController();
  final _jk = TextEditingController();
  final _umur = TextEditingController();
  final _kasus = TextEditingController();

  final dbRef = FirebaseDatabase.instance.ref("narapidana");

  void simpanData() {
    dbRef.push().set({
      "nama": _nama.text,
      "jk": _jk.text,
      "umur": _umur.text,
      "kasus": _kasus.text,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Data")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nama, decoration: InputDecoration(labelText: "Nama")),
            TextField(controller: _jk, decoration: InputDecoration(labelText: "Jenis Kelamin")),
            TextField(controller: _umur, decoration: InputDecoration(labelText: "Umur")),
            TextField(controller: _kasus, decoration: InputDecoration(labelText: "Kasus")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: simpanData,
              child: Text("Simpan"),
            )
          ],
        ),
      ),
    );
  }
}