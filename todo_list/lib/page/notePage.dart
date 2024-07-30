import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/noteControl.dart';
import 'package:todo_list/module/colorBar.dart';
import 'package:intl/intl.dart';

class NotePage extends StatefulWidget {
  final String title;
  final String content;
  final String dateTime;
  final Color color;
  final int option;
  final bool read;

  const NotePage(
      {super.key,
      required this.title,
      required this.content,
      required this.dateTime,
      required this.color,
      required this.option,
      required this.read});

  @override
  State<NotePage> createState() => _NotePage();
}

class _NotePage extends State<NotePage> {
  final NoteController noteController = Get.put(NoteController());
  late TextEditingController titleControl;
  late TextEditingController contentControl;
  late Color color;
  late int option;
  late String currentDatetime;
  bool read = true;

  @override
  void initState() {
    super.initState();
    titleControl = TextEditingController(text: widget.title);
    contentControl = TextEditingController(text: widget.content);
    color = widget.color;
    option = widget.option;
    read = widget.read;
    currentDatetime = widget.dateTime;
  } // this function is called when the page is loaded and it initializes the controllers and the color of the note

  void changeColor(Color newColor) {
    setState(() {
      color = newColor; // Change the color of the note
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
  } // save and back to the home page

  void edit() {
    setState(() {
      read = false;
      option = 2;
    });
  }

  void saveEdit() {
    setState(() {
      read = true;
    });

    String dateTime = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    noteController.saveEdit(
      noteController.notes
          .indexWhere((element) => element.title == widget.title),
      titleControl.text.isEmpty ? 'Untitled' : titleControl.text,
      contentControl.text.isEmpty ? 'No content' : contentControl.text,
      dateTime,
      color,
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        actions: [
          IconButton(
            onPressed: () {
              switch (option) {
                case 0:
                  save();
                  break;
                case 1:
                  edit();
                  break;
                case 2:
                  saveEdit();
                  break;
              }
            },
            icon: Icon(
              option == 0
                  ? Icons.save
                  : option == 1
                      ? Icons.edit
                      : option == 2
                          ? Icons.save
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
            readOnly: read,
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
            opacity: option == 1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                currentDatetime,
                style: TextStyle(
                  fontSize: 14,
                  color: color.computeLuminance() > 0.5
                      ? Colors.grey
                      : Colors.white,
                ),
              ),
            ),
          ),
          // This is the content form field
          Expanded(
            child: TextFormField(
              readOnly: read,
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
          // This is the color bar
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transform: Matrix4.translationValues(
                option == 1 ? -1000.0 : 0.0, 0.0, 0.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: option == 1
                  ? const SizedBox()
                  : Row(
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
                              elevation: color == colorDot.color ? 5 : 0,
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
    );
  }
}
