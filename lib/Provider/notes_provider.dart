import 'package:flutter/material.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/repository/notes_repository.dart';

class NotesProvider extends ChangeNotifier {
  final NotesRepository _notesRepository;
  NotesProvider(this._notesRepository);

  List<Notes> get notesList => [..._notesList];
  List<Notes> _notesList = [];

  Notes saveNotes(Notes notes) {
    final readyToSave = notes.copyWith(
      title: notes.body!.isNotEmpty ? notes.body!.split('\n')[0] : notes.title,
      lastEdit: DateTime.now(),
    );
    int id;
    if (notes.id == 0) {
      id = _notesRepository.saveNotes(note: readyToSave);
    } else {
      id = _notesRepository.updateNotes(note: readyToSave);
    }
    getAllNotes();
    notifyListeners();
    return notes.copyWith(id: id);
  }

  void getAllNotes() {
    final ordered = _notesRepository.getAllNotes()!;
    _notesList = ordered;
  }

  void deleteNotes(Notes notes) {
    _notesRepository.deleteNotes(id: notes.id!);
    getAllNotes();
    notifyListeners();
  }
}
