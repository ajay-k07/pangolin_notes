part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  final List<Notes> notesList = [];
  @override
  List<Object?> get props => [];
}

class NotesLoading extends NotesState {
  @override
  List<Object?> get props => [];
}

class NotesLoaded extends NotesState {
  final List<Notes> notesList;

  const NotesLoaded({required this.notesList});
  @override
  List<Object?> get props => [notesList];
}

class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);
  @override
  List<Object?> get props => [];
}
