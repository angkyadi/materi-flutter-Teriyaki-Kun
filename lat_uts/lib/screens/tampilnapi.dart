import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'datanapi.dart';

class TampilNapi extends StatefulWidget {
  @override
  _TampilNapiState createState() => _TampilNapiState();
}

class _TampilNapiState extends State<TampilNapi> {
  final dbRef = FirebaseDatabase.instance.ref("narapidana");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Narapidana'),
      ),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            DatabaseEvent event = snapshot.data!;
            Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
            if (data != null) {
              List<Map<String, String>> items = [];
              data.forEach((key, value) {
                items.add({
                  'key': key,
                  'nama': value['nama'] ?? '',
                  'jk': value['jk'] ?? '',
                  'umur': value['umur'] ?? '',
                  'kasus': value['kasus'] ?? '',
                });
              });
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]['nama']!),
                    subtitle: Text('JK: ${items[index]['jk']}, Umur: ${items[index]['umur']}, Kasus: ${items[index]['kasus']}'),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => datanapi()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}