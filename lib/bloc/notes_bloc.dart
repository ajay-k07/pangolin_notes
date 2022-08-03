import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/repository/notes_repository.dart';
import 'package:pangolin_notes/repository/notes_repository_impl.dart';
import 'package:pangolin_notes/service/objectbox_notes_service_impl.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository repository =
      NotesRepoImpl(notesSevice: ObjectBoxNotesSevice());
  List<Notes> _notesList = [];
  NotesBloc() : super(NotesInitial()) {
    on<NotesEvent>((event, emit) {
      if (event is LoadNotesEvent) {
        try {
          emit(NotesLoading());
          final notesList = repository.getAllNotes()!;
          _notesList = notesList;
          emit(NotesLoaded(notesList: notesList));
        } catch (e) {
          emit(NotesError(e.toString()));
        }
      }
      if (event is SaveNotesEvent) {
        try {
          emit(NotesLoading());
          repository.saveNotes(note: event.notes);
          final notesList = repository.getAllNotes()!;
          _notesList = notesList;
          emit(NotesLoaded(notesList: notesList));
        } catch (e) {
          emit(NotesError(e.toString()));
        }
      }
      if (event is UpdateNotesEvent) {
        try {
          emit(NotesLoading());
          repository.saveNotes(note: event.notes);
          final notesList = repository.getAllNotes()!;
          _notesList = notesList;
          emit(NotesLoaded(notesList: notesList));
        } catch (e) {
          emit(NotesError(e.toString()));
        }
      }
      if (event is DeleteNotesEvent) {
        try {
          emit(NotesLoading());
          repository.deleteNotes(id: event.id);
          final notesList = repository.getAllNotes()!;
          _notesList = notesList;
          emit(NotesLoaded(notesList: [...repository.getAllNotes()!]));
        } catch (e) {
          emit(NotesError(e.toString()));
        }
      }
    });
  }
}
