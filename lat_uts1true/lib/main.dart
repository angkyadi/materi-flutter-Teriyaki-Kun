import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lat_uts1true/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lat_uts1true/screens/data_napi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Napi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbRef = FirebaseDatabase.instance.ref().child('napi');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Napi'),
      ),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List<Map<String, dynamic>> napiList = [];
            data.forEach((key, value) {
              napiList.add({
                'nama': value['nama'],
                'jenis_kelamin': value['jenis_kelamin'],
                'usia': value['usia'],
                'kasus': value['kasus'],
              });
            });
            return ListView.builder(
              itemCount: napiList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(napiList[index]['nama']),
                  subtitle: Text('Jenis Kelamin: ${napiList[index]['jenis_kelamin']}, Usia: ${napiList[index]['usia']}, Kasus: ${napiList[index]['kasus']}'),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DataNapi()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Data',
      ),
    );
  }
}

