import 'package:final_exam/model/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper databaseHelper = DatabaseHelper._();
  Database? db;

  Future<void> initDB() async {
    String directorypath = await getDatabasesPath();
    String path = join(directorypath, 'note.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String query =
          "CREATE TABLE IF NOT EXISTS notestable(note_id INTEGER PRIMARYKEY AUTOINCREMENT,note_title TEXT NOT NULL,note_notes TEXT NOT NULL);";
      await db.execute(query);
      print("==============");
      print("==============");
    });
  }

  Future<int> insertNote({required NotesModel notemodel}) async {
    if (db == null) {
      await initDB();
    }

    String query = "INSERT INTO notestable(note_title,note_notes)VALUES(?,?);";
    List args = [
      notemodel.title,
      notemodel.notes,
    ];
    int? res = await db?.rawInsert(query, args);
    return res!;
  }

  Future<List<NotesModel>> fetchAllNotes() async {
    if (db == null) {
      await initDB();
    }

    String query = "SELECT * FROM notestable;";

    List<Map<String, dynamic>>? allnotesRecord = await db?.rawQuery(query);
    List<NotesModel> allfetchnote =
        allnotesRecord!.map((e) => NotesModel.frommap(e)).toList();

    return allfetchnote;
  }

  Future<int> deleteNotes({required int id}) async {
    if (db == null) {
      initDB();
    }
    String query = "DELETE * FROM notestable WHERE note_id=?;";
    List args = [id];
    int res = await db!.rawDelete(query, args);
    return res;
  }
}
