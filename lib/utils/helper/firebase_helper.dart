import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam/model/note_model.dart';

class FirebaseHelper {
  FirebaseHelper._();
  static final FirebaseHelper firebaseHelper = FirebaseHelper._();
  static FirebaseFirestore db = FirebaseFirestore.instance;

  insertNote({required NotesModel noteModel}) async {
    await db.collection("Notes").add({
      "title": noteModel.title,
      "note": noteModel.notes,
    });
  }
}
