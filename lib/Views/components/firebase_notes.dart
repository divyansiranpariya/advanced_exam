import 'package:final_exam/model/note_model.dart';
import 'package:final_exam/utils/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FirebaseNotes extends StatefulWidget {
  const FirebaseNotes({super.key});

  @override
  State<FirebaseNotes> createState() => _FirebaseNotesState();
}

class _FirebaseNotesState extends State<FirebaseNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String? title;
  String? note;
  GlobalKey<FormState> formKey = GlobalKey();
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
                Get.toNamed('/');
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
                              border: OutlineInputBorder(), hintText: "Title"),
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
                              border: OutlineInputBorder(), hintText: "Notes"),
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
                                    NotesModel noteModel =
                                        NotesModel(title: title, notes: note);
                                    FirebaseHelper.firebaseHelper
                                        .insertNote(noteModel: noteModel);

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
    );
  }
}
