import 'package:flutter/material.dart';

class NotesModel {
  int? id;
  String? title;
  String? notes;

  NotesModel({this.id, required this.title, required this.notes});

  factory NotesModel.frommap(Map<String, dynamic> data) {
    return NotesModel(
        id: data['note_id'],
        title: data['note_title'],
        notes: data['note_notes']);
  }
}
