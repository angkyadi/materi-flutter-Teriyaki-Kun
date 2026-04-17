import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'datanapi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbRef = FirebaseDatabase.instance.ref("narapidana");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data Narapidana")),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.snapshot.value as Map?;

          if (data == null) {
            return Center(child: Text("Belum ada data"));
          }

          final items = data.entries.toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index].value;

              return Card(
                child: ListTile(
                  title: Text(item['nama']),
                  subtitle: Text(
                    "JK: ${item['jk']} | Umur: ${item['umur']} \nKasus: ${item['kasus']}"
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => datanapi()),
          );
        },
      ),
    );
  }
}