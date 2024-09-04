import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/module/note.dart';
import 'package:todo_list/controller/noteControl.dart';
import 'package:todo_list/page/notePage.dart';

class HomePageController extends GetxController {
  var isGridView = true.obs;
  var isSearchBar = false.obs;
  var searchController = TextEditingController();
  var focusNode = FocusNode();
  RxList searchList = <Note>[].obs;
  final noteController = Get.find<NoteController>();

  @override
  void onInit() {
    super.onInit();
    searchList.value = noteController.notes;
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void searchBarToggle() {
    isSearchBar.value = !isSearchBar.value;
    if (!isSearchBar.value) searchList.value = noteController.notes;
    searchController.clear();
    focusNode.requestFocus();
  }

  void delete(int index) {
    noteController.notes.removeAt(index);
    if (isSearchBar.value) searchList.removeAt(index);
  }

  void tap(int index) {
    var note = searchList[index];
    noteController.index.value = index;
    noteController.option.value = 1;
    noteController.color.value = note.color;
    noteController.title.value = note.title;
    noteController.content.value = note.content;
    noteController.date.value = note.date;
    noteController.readOnly.value = true;

    Get.to(
      () => const NotePage(),
      transition: Transition.rightToLeft, // animation
      duration: const Duration(milliseconds: 500),
    );
  }

  void add() {
    noteController.option.value = 0;
    noteController.color.value = Colors.white;
    noteController.title.value = '';
    noteController.content.value = '';
    noteController.readOnly.value = false;

    Get.to(
      () => const NotePage(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
    );
  }

  void runFilter(String keyword) {
    if (keyword.isEmpty) {
      searchList.value = noteController.notes;
    } else {
      searchList.value = noteController.notes
          .where((note) =>
              note.title.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
  }
}
