import 'package:get/get.dart';
import 'package:todo_list/module/note.dart';
import 'package:flutter/material.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;

  void addNote(String title, String content, String date, Color color) {
    notes.add(Note(title: title, content: content, date: date, color: color));
  }

  void deleteNote(int index) {
    notes.removeAt(index);
  }
}
