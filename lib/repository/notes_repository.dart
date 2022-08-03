import 'package:pangolin_notes/model/notes.dart';

abstract class NotesRepository {
  int saveNotes({required Notes note});
  List<Notes>? getAllNotes();
  int updateNotes({required Notes note});
  bool deleteNotes({required int id});
}
