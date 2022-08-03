import 'package:flutter_test/flutter_test.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/repository/notes_repository.dart';
import 'package:pangolin_notes/repository/notes_repository_impl.dart';
import 'package:pangolin_notes/service/notes_service.dart';

import '../service/mock_notes_service.dart';

void main() {
  group('Notes Provider Test', () {
    final _notes = Notes();
    late NotesService mockService;
    late NotesRepository notesRepoImpl;
    late NotesProvider notesProvider;

    setUp(() {
      mockService = MockNotesService();
      notesRepoImpl = NotesRepoImpl(notesSevice: mockService);
      notesProvider = NotesProvider(notesRepoImpl);
    });

    test('Save', () {
      notesProvider.getAllNotes();
      int _oldLen = notesProvider.notesList.length;
      notesProvider.saveNotes(_notes);
      int _newLen = notesProvider.notesList.length;
      expect(_newLen, _oldLen + 1);
      final _lastElement = notesProvider.notesList.last.id;
      expect(_lastElement, _notes.copyWith(id: _newLen + 1).id);
    });
    test('Update Body', () {
      notesProvider.getAllNotes();
      final note = notesProvider.notesList[2];

      var newNote = note.copyWith(body: 'new text');
      notesProvider.saveNotes(newNote);
      expect(
          notesProvider.notesList
              .firstWhere((element) => element.id == newNote.id)
              .body,
          newNote.body);
    });

    test('Update Title', () {
      notesProvider.getAllNotes();
      final note = notesProvider.notesList[2];
      var newNote = note.copyWith(body: 'new text', title: 'new text');
      notesProvider.saveNotes(newNote);
      expect(
          notesProvider.notesList
              .firstWhere((element) => element.id == newNote.id)
              .title,
          newNote.title);
    });

    test('Update Category', () {
      notesProvider.getAllNotes();
      final note = notesProvider.notesList[2];
      var newNote = note.copyWith(category: 'new category');
      notesProvider.saveNotes(newNote);
      expect(
          notesProvider.notesList
              .firstWhere((element) => element.id == newNote.id)
              .category,
          newNote.category);
    });

    test('Update Last Edit', () {
      notesProvider.getAllNotes();
      final note = notesProvider.notesList[2];
      final lastEdit = DateTime.now();
      var newNote =
          note.copyWith(title: '', body: 'new text', category: 'new category');
      newNote = note.copyWith(id: note.id, lastEdit: lastEdit);
      notesProvider.saveNotes(newNote);
      // check is the last edit getting updated during save
      bool diff = notesProvider.notesList
          .firstWhere((element) => element.id == newNote.id)
          .lastEdit!
          .isAfter(newNote.lastEdit!);
      expect(diff, true);

      expect(
          notesProvider.notesList
              .firstWhere((element) => element.id == newNote.id)
              .body,
          newNote.body);
      //checks for empty title and keeps the fist line of the body
      expect(
          notesProvider.notesList
              .firstWhere((element) => element.id == newNote.id)
              .title,
          newNote.body);
    });

    test('Get All Notes', () {
      notesProvider.getAllNotes();
      expect(notesProvider.notesList.length, 3);
      final newNote = Notes();
      notesProvider.saveNotes(newNote);
      expect(notesProvider.notesList.length, 4);
    });

    test('Delete Note', () {
      notesProvider.getAllNotes();
      final notes = notesProvider.notesList.first;
      notesProvider.deleteNotes(notes);
      expect(notesProvider.notesList.first.id, 2);
    });
  });
}
