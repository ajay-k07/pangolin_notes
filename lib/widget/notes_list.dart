import 'package:flutter/widgets.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/widget/notes_tile.dart';

class NotesList extends StatelessWidget {
  final BoxConstraints constrain;
  final NotesProvider value;
  final Function notesSelected;
  final Function deletedNote;

  const NotesList({
    super.key,
    required this.constrain,
    required this.value,
    required this.notesSelected,
    required this.deletedNote,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: constrain.maxHeight,
        width: constrain.maxWidth * 0.4,
        child: ListView.builder(
          itemCount: value.notesList.length,
          itemBuilder: (context, index) {
            final notes = value.notesList[index];
            return NotesTile(
              notes: notes,
              selectedNote: notesSelected,
              deletedNote: deletedNote,
            );
          },
        ),);
  }
}
