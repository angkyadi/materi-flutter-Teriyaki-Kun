import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/models/models.dart';
import 'package:notes/services/note_services.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;

  const NoteDialog({super.key, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  @override
  void initState() {
    super.initState();
    if (widget.note != null){
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  Future <void> _pickImage() async {
    final pickedFile = 
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null ? 'Add Notes' : 'Update Notes'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Title',
            textAlign: TextAlign.start,
          ),
          const Padding(padding: EdgeInsets.only(top : 20),
          child: Text('Description: '),
          ),
          TextField(
            controller: _descriptionController,
            maxLines: null,
          ),
          const Padding(padding: EdgeInsets.only(top : 20),
          child: Text('Image : '),
          ),
        ],
      ),
    );
  }
}