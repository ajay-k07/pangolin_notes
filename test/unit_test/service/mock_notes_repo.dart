import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/repository/notes_repository_impl.dart';

import 'mock_notes_service.dart';

class MockNotesRepo implements NotesRepoImpl {
  @override
  final MockNotesService notesSevice;

  MockNotesRepo({required this.notesSevice});

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
