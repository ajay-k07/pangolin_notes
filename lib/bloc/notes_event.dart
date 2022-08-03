part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

//CRED

//Save or Create
class InitNotesEvent extends NotesEvent {
  @override
  List<Object?> get props => [];
}

class SaveNotesEvent extends NotesEvent {
  final Notes notes;

  const SaveNotesEvent(this.notes);

  @override
  List<Object?> get props => [notes];
}

// Read
class LoadNotesEvent extends NotesEvent {
  @override
  List<Object?> get props => [];
}

// Update
class UpdateNotesEvent extends NotesEvent {
  final Notes notes;
  const UpdateNotesEvent(this.notes);

  @override
  List<Object?> get props => [notes];
}

// Detele

class DeleteNotesEvent extends NotesEvent {
  final int id;
  const DeleteNotesEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddNewNotesEvent extends NotesEvent {
  @override
  List<Object?> get props => [];
}
