import 'package:mocktail/mocktail.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/service/notes_service.dart';

class MockNotesService extends Mock implements NotesService {
  final db = [
    Notes(id: 1, body: 'one', title: 'one'),
    Notes(id: 2, body: 'two', title: 'two'),
    Notes(id: 3, body: 'three', title: 'three'),
  ];
  @override
  int saveNote({required Notes note}) {
    if (note.id == 0) {
      db.add(note.copyWith(id: db.length + 2));
      return db.length + 1;
    } else {
      int index = db.indexWhere((element) => element.id == note.id);
      db[index] = note;
      return note.id!;
    }
  }

  @override
  List<Notes> getAllNotes() {
    return [...db];
  }

  @override
  bool deleteNote({required int id}) {
    int isremoved = db.length;
    db.removeWhere((element) => element.id == id);
    return isremoved > db.length;
  }
}
