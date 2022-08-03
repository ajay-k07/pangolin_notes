import 'package:pangolin_notes/model/notes.dart';

abstract class NotesService {
  static Future<void> setup() async {}
  int saveNote({required Notes note});
  List<Notes> getAllNotes();
  int updateNote({required Notes note});
  bool deleteNote({required int id});
}
