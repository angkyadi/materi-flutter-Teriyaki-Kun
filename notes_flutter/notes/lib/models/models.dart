import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? id;
  final String title;
  final String description;
  String? imageUrl;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Note({
    this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Note.fromDocument(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String,dynamic>;
    return Note(
      id: doc.id,
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],

    );
  }

  Map<String,dynamic> toDocument(){
    return {
      'title' : title,
      'description' : description,
      'imageUrl' : imageUrl,
      'createdAt' : createdAt,
      'updatedAt' : updatedAt,
    };
  }
}