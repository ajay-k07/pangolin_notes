import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/model/objectbox.g.dart';
import 'package:pangolin_notes/service/notes_service.dart';
import 'package:pangolin_notes/utils/object_box.dart';

class ObjectBoxNotesSevice implements NotesService {
  factory ObjectBoxNotesSevice() {
    return _instance;
  }
  ObjectBoxNotesSevice._privateConstructor();
  static final ObjectBoxNotesSevice _instance =
      ObjectBoxNotesSevice._privateConstructor();

  static late ObjectBoxInterface _objectbox;
  static late Store store = _objectbox.store;
  final notesBox = store.box<Notes>();

  static Future<void> setup() async {
    _objectbox = await ObjectBoxInterface.create();
  }

  static Future<void> close() async {
    if (!_objectbox.store.isClosed()) {
      _objectbox.store.close();
    }
  }

  @override
  int saveNote({required Notes note}) {
    return notesBox.put(note);
  }

  @override
  List<Notes> getAllNotes() {
    return notesBox.getAll();
  }

  @override
  int updateNote({required Notes note}) {
    return notesBox.put(note);
  }

  @override
  bool deleteNote({required int id}) {
    return notesBox.remove(id);
  }
}
