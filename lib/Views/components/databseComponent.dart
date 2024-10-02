import 'package:final_exam/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helper/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String? title;
  String? note;
  GlobalKey<FormState> formKey = GlobalKey();
  Future? getAllData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.databaseHelper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Note App"),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/FirebaseNotes');
                },
                icon: Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 20,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add Notes"),
                    content: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (val) {
                              title = val;
                            },
                            controller: titleController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Title"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: noteController,
                            onSaved: (val) {
                              note = val;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Notes"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Cancle")),
                                ElevatedButton(
                                    onPressed: () async {
                                      NotesModel noteMOdel =
                                          NotesModel(title: title, notes: note);
                                      int? res = await DatabaseHelper
                                          .databaseHelper
                                          .insertNote(notemodel: noteMOdel);
                                      if (res >= 1) {
                                        GetSnackBar(
                                          title: "Success",
                                          backgroundColor: Colors.green,
                                        );
                                        Get.back();
                                      } else {
                                        GetSnackBar(
                                          title: "Failed",
                                          backgroundColor: Colors.red,
                                        );
                                        Get.back();
                                      }

                                      titleController.clear();
                                      noteController.clear();
                                    },
                                    child: Text("Add")),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: getAllData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR"),
              );
            } else if (snapshot.hasData) {
              List<NotesModel> allData = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, i) {
                    return Container(
                      child: Column(
                        children: [
                          Text("${allData[i].title}"),
                          Text("${allData[i].notes}"),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    DatabaseHelper.databaseHelper
                                        .deleteNotes(id: allData[i].id!);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, i) {
                    return Container();
                  },
                  itemCount: allData.length);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
