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
  bool grid_view = true;
  bool search = false;
  final NoteController noteController = Get.put(NoteController());
  final TextEditingController searchControl = TextEditingController();

  void add() {
    Get.to(
      () => const NotePage(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 500),
    );
  }

  void view() {
    setState(() {
      grid_view = !grid_view;
    });
  }

  void searchNote() {
    setState(() {
      search = !search;
      searchControl.clear();
      searchList = noteController.notes;
    });
  }

  List<Note> searchList = [];

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
  }

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
                  color: grid_view ? Colors.grey : Colors.black,
                  onPressed: view,
                  icon: const Icon(Icons.grid_view_outlined)),
              IconButton(
                  color: grid_view ? Colors.black : Colors.grey,
                  onPressed: view,
                  icon: const Icon(Icons.list_alt_rounded)),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(child: Obx(() {
            return searchList.isEmpty
                ? const Text(
                    'Empty',
                    textAlign: TextAlign.center,
                  )
                : grid_view
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
                          return Card(
                            color: note.color,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    note.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
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
                                          color: note.color.computeLuminance() <
                                                  0.5
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              4), // Optional: Add some space between date and content
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
                                ),
                              ],
                            ),
                          );
                        })
                    : ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: (context, index) {
                          var note = searchList[index];
                          return Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note.date,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            note.color.computeLuminance() < 0.5
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
                                // onTap: () {
                                //   Get.to(
                                //     () => NotePage(note: note),
                                //     transition: Transition.rightToLeft,
                                //     duration: const Duration(milliseconds: 500),
                                //   );
                                // },
                              ));
                        },
                      );
          })),
        ],
      ),
    );
  }
}
