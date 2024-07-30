import 'package:flutter/material.dart';
import 'package:todo_list/controller/noteControl.dart';
import 'package:todo_list/module/note.dart';
import 'package:todo_list/page/notePage.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int option = 0; // 0: add, 1: edit, 2: save edit (notePage)
  bool gridView = true; // switch view (grid or list)
  bool search = false; // search bar
  final NoteController noteController = Get.put(NoteController());
  final TextEditingController searchControl = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  List<Note> searchList = [];

  // Add the following methods to the _HomePage class:
  void add() {
    Get.to(
      () => const NotePage(
        title: '',
        content: '',
        dateTime: '',
        color: Colors.white,
        option: 0,
        read: false,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
    );
  } // add note

  void view() {
    setState(() {
      gridView = !gridView;
    });
  } // change view (grid or list)

  void searchNote() {
    setState(() {
      search = !search;
      searchControl.clear();
      searchList = noteController.notes;
      if (search) {
        searchFocus.requestFocus();
      } else {
        searchFocus.unfocus();
      } // Reset search list
    });
  } // search note (by title)

  void runFilter(String enteredKeyword) {
    searchList = noteController.notes;
    if (enteredKeyword.isEmpty) {
      searchList = noteController.notes;
    } else {
      searchList = noteController.notes
          .where((note) =>
              note.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      searchList = searchList;
    });
  } // search note function (filter)

  void delete(int index) {
    setState(() {
      noteController.deleteNote(index);
    });
  } // delete note when swipe

  void whenTap(int index) {
    var note = searchList[index];
    Get.to(
      () => NotePage(
        title: note.title,
        content: note.content,
        dateTime: note.date,
        color: note.color,
        option: 1,
        read: true,
      ),
      transition: Transition.rightToLeft, // animation
      duration: const Duration(milliseconds: 500),
    );
  } // edit note when tap on it

  @override
  initState() {
    searchList = noteController.notes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: search
            ? TextFormField(
                onChanged: (value) => runFilter(value),
                controller: searchControl,
                focusNode: searchFocus,
                decoration: const InputDecoration(
                  hintText: 'Search..',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 83, 83, 83),
                  ),
                  border: InputBorder.none,
                ),
              )
            : null,
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        actions: [
          IconButton(
              onPressed: searchNote,
              icon:
                  search ? const Icon(Icons.cancel) : const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Notes',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 35,
                  height: 35,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          )),
                      onPressed: add,
                      child: const Icon(color: Colors.black, Icons.add)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  color: gridView ? Colors.grey : Colors.black,
                  onPressed: view,
                  icon: const Icon(Icons.grid_view_outlined)),
              IconButton(
                  color: gridView ? Colors.black : Colors.grey,
                  onPressed: view,
                  icon: const Icon(Icons.list_alt_rounded)),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 20),

          // Display notes in grid or list view
          /* - Check notes list empty
             - Edit notes
             - Delete notes
             - Animation for edit notes
           */
          Expanded(child: Obx(() {
            return searchList.isEmpty
                ? const Text(
                    'Empty',
                    textAlign: TextAlign.center,
                  )
                : gridView
                    ? GridView.builder(
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        itemCount: searchList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          var note = searchList[index];
                          return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                delete(index);
                              },
                              child: Card(
                                color: note.color,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        note.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            note.date,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: note.color
                                                          .computeLuminance() <
                                                      0.5
                                                  ? Colors.white
                                                  : Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            note.content,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () => whenTap(index),
                                    ),
                                  ],
                                ),
                              ));
                        })
                    : ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          var note = searchList[index];
                          return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                delete(index);
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 15, right: 15),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: note.color,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      note.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          note.date,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                note.color.computeLuminance() <
                                                        0.5
                                                    ? Colors.white
                                                    : Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          note.content,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () => whenTap(index),
                                  )));
                        },
                      );
          })),
        ],
      ),
    );
  }
}
