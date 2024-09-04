import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/module/note.dart';
import 'package:flutter/material.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  var readOnly = true.obs;
  var option = 0.obs;
  var title = ''.obs;
  var content = ''.obs;
  var index = 0.obs;
  var date = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()).obs;

  Rx<Color> color = Colors.white.obs;

  void addNote(String title, String content, Color color) {
    String dateTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    notes.add(Note(
        title: title.isEmpty ? 'Untitled' : title,
        content: content.isEmpty ? 'No content' : content,
        date: dateTime,
        color: color));
    Get.back();
  }

  void editNote(
      int index, String title, String content, String dateTime, Color color) {
    notes[index] = Note(
        title: title.isEmpty ? '' : title,
        content: content.isEmpty ? '' : content,
        date: dateTime,
        color: color);
    readOnly.value = false;
    option.value = 2;
  }

  void saveEdit(int index, String title, String content, Color color) {
    String dateTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    notes[index] = Note(
        title: title.isEmpty ? 'Untitled' : title,
        content: content.isEmpty ? 'No content' : content,
        date: dateTime,
        color: color);

    Get.back();
  }

  void changeColor(int index, Color newColor) {
    notes[index].color = newColor;
  }
}
