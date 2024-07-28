import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/noteControl.dart';
import 'package:todo_list/module/colorBar.dart';
import 'package:intl/intl.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePage();
}

class _NotePage extends State<NotePage> {
  final NoteController noteController = Get.put(NoteController());
  final TextEditingController titleControl = TextEditingController();
  final TextEditingController contentControl = TextEditingController();

  Color color = Colors.white;
  Color? selectedColor = Colors.white;
  void changeColor(Color newColor) {
    setState(() {
      selectedColor = newColor;
      color = newColor;
    });
  }

  void save() {
    String dateTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    noteController.addNote(
      titleControl.text.isEmpty ? 'Untitled' : titleControl.text,
      contentControl.text.isEmpty ? 'No content' : contentControl.text,
      dateTime,
      color,
    );

    Get.back();
  }

  void back() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        leading: IconButton(
            onPressed: back,
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        actions: [
          IconButton(onPressed: save, icon: const Icon(Icons.save)),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: titleControl,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 20, right: 20),
            ),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: contentControl,
              decoration: const InputDecoration(
                hintText: 'Type something...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              ),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              expands: true,
              maxLines: null,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: colorDots.map((colorDot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      changeColor(colorDot.color);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: selectedColor == colorDot.color ? 5 : 0,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(30),
                      backgroundColor: colorDot.color,
                      side: const BorderSide(
                        color: Color.fromARGB(255, 245, 245,
                            245), // Set the border color to white
                        width: 3, // Set the border width
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
