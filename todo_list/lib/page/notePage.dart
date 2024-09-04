import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/noteControl.dart';
import 'package:todo_list/module/colorBar.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePage();
}

class _NotePage extends State<NotePage> {
  final noteController = Get.find<NoteController>();
  late TextEditingController titleControl;
  late TextEditingController contentControl;

  @override
  void initState() {
    super.initState();
    titleControl = TextEditingController(text: noteController.title.value);
    contentControl = TextEditingController(text: noteController.content.value);
  } // this function is called when the page is loaded and it initializes the controllers and the color of the note

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: noteController.color.value,
          appBar: AppBar(
            backgroundColor: noteController.color.value,
            leading: IconButton(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            actions: [
              IconButton(
                onPressed: () {
                  switch (noteController.option.value) {
                    case 0:
                      noteController.addNote(titleControl.text,
                          contentControl.text, noteController.color.value);
                      break;
                    case 1:
                      noteController.editNote(
                          noteController.index.value,
                          titleControl.text,
                          contentControl.text,
                          noteController.date.value,
                          noteController.color.value);
                      break;
                    default:
                      noteController.saveEdit(
                          noteController.index.value,
                          titleControl.text,
                          contentControl.text,
                          noteController.color.value);
                  }
                },
                icon: Icon(
                  noteController.option.value == 0
                      ? Icons.save
                      : noteController.option.value == 1
                          ? Icons.edit
                          : Icons.save,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: Column(
            children: [
              // This is title form field
              TextFormField(
                readOnly: noteController.readOnly.value,
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
              // This is display the date time
              AnimatedOpacity(
                opacity: noteController.option.value == 1 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    noteController.date.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: noteController.color.value.computeLuminance() > 0.5
                          ? Colors.grey
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              // This is the content form field
              Expanded(
                child: TextFormField(
                  readOnly: noteController.readOnly.value,
                  controller: contentControl,
                  decoration: const InputDecoration(
                    hintText: 'Type something...',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 20, right: 20, top: 10),
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  expands: true,
                  maxLines: null,
                ),
              ),
              // This is the color bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                transform: Matrix4.translationValues(
                    noteController.option.value == 1 ? -1000.0 : 0.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: noteController.option.value == 1
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: colorDots.map((colorDot) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  noteController.color.value = colorDot.color;
                                },
                                child: null,
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.black,
                                  elevation: noteController.color.value ==
                                          colorDot.color
                                      ? 5
                                      : 0,
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
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
