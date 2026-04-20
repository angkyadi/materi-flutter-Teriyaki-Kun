import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/models.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as path;

class NoteServices {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _notesCollection = _database.collection('notes');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> addNote(Note note) async {
    Map<String, dynamic> newNote = {
      'title' : note.title,
      'description' : note.description,
      'imageUrl' : note.imageUrl,
      'createdAt' : FieldValue.serverTimestamp(),
      'updatedAt' : FieldValue.serverTimestamp(),
    };
    await _notesCollection.add(newNote);
  }

  static Stream<List<Note>> getNoteList (){
    return _notesCollection.snapshots().map((snapshot){
      return snapshot.docs.map ((doc){
        Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
        return Note(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          createdAt: data['createdAt'] != null ? data['created_at'] as Timestamp : null,
          updatedAt: data['updatedAt'] != null ? data['updated_at'] as Timestamp : null,
        );
      }).toList();
    });
  }

  static Future<void> updateNote (Note note) async {
    Map<String,dynamic> updatedNote = {
      'title' : note.title,
      'description' : note.description,
      'imageUrl' : note.imageUrl,
      'createdAt' : note.createdAt,
      'updatedAt' : FieldValue.serverTimestamp(),
    };
    await _notesCollection.doc(note.id).update(updatedNote);
  }

  static Future<void> deleteNote(Note note)async {
    await _notesCollection.doc(note.id).delete();
  }

  static Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = path.basename(imageFile.path);
      Reference ref = _storage.ref().child('images/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }
}