import 'package:flutter/material.dart';
import 'package:todo_list/controller/noteControl.dart';
import 'package:todo_list/controller/pageControl.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final HomePageController pageController = Get.find<HomePageController>();
  final NoteController noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          title: pageController.isSearchBar.value
              ? TextFormField(
                  onChanged: (value) => pageController.runFilter(value),
                  controller: pageController.searchController,
                  focusNode: pageController.focusNode,
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
                onPressed: pageController.searchBarToggle,
                icon: pageController.isSearchBar.value
                    ? const Icon(Icons.cancel)
                    : const Icon(Icons.search)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined)),
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
                        onPressed: pageController.add,
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
                    color: pageController.isGridView.value
                        ? Colors.grey
                        : Colors.black,
                    onPressed: pageController.toggleView,
                    icon: const Icon(Icons.grid_view_outlined)),
                IconButton(
                    color: pageController.isGridView.value
                        ? Colors.black
                        : Colors.grey,
                    onPressed: pageController.toggleView,
                    icon: const Icon(Icons.list_alt_rounded)),
                const SizedBox(width: 15),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
                child: pageController.searchList.isEmpty
                    ? const Text(
                        'Empty',
                        textAlign: TextAlign.center,
                      )
                    : pageController.isGridView.value
                        ? GridView.builder(
                            padding: const EdgeInsets.only(left: 13, right: 13),
                            itemCount: pageController.searchList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              var note = pageController.searchList[index];
                              return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    pageController.delete(index);
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            onTap: () =>
                                                pageController.tap(index)),
                                      ],
                                    ),
                                  ));
                            })
                        : ListView.builder(
                            itemCount: pageController.searchList.length,
                            itemBuilder: (context, index) {
                              var note = pageController.searchList[index];
                              return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    pageController.delete(index);
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
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () => pageController.tap(index),
                                      )));
                            },
                          )),
          ],
        ),
      );
    });
  }
}
