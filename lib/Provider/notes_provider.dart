import 'package:flutter/material.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/service/objectbox_notes_service_impl.dart';

class NotesProvider extends ChangeNotifier {
  final ObjectBoxNotesSevice _notesSevice;
  NotesProvider(this._notesSevice);

  List<Notes> get notesList => [..._notesList];
  List<Notes> _notesList = [];
  Notes saveNotes(Notes notes) {
    final readyToSave = notes.copyWith(
      title: notes.body!.isNotEmpty ? notes.body!.split('\n')[0] : notes.title,
      lastEdit: DateTime.now(),
    );
    final id = _notesSevice.saveNote(note: readyToSave);
    getAllNotes();
    notifyListeners();
    return notes.copyWith(id: id);
  }

  void getAllNotes() {
    final ordered = _notesSevice.getAllNotes();
    ordered.sort(
      (a, b) => b.lastEdit!.compareTo(a.lastEdit!),
    );
    _notesList = ordered;
  }

  void deleteNotes(Notes notes) {
    _notesSevice.deleteNote(id: notes.id!);
    getAllNotes();
    notifyListeners();
  }
}
