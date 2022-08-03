import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/repository/notes_repository.dart';
import 'package:pangolin_notes/service/notes_service.dart';

class NotesRepoImpl implements NotesRepository {
  final NotesService notesSevice;

  NotesRepoImpl({required this.notesSevice});

  @override
  int saveNotes({required Notes note}) {
    return notesSevice.saveNote(note: note);
  }

  @override
  List<Notes>? getAllNotes() {
    return notesSevice.getAllNotes();
  }

  @override
  int updateNotes({required Notes note}) {
    return notesSevice.updateNote(note: note);
  }

  @override
  bool deleteNotes({required int id}) {
    return notesSevice.deleteNote(id: id);
  }
}
