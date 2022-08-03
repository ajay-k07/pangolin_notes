import 'package:flutter/material.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/widget/notes_grid_tile.dart';

class NotesGrid extends StatefulWidget {
  final BoxConstraints constrain;
  final Function notesSelected;
  final List<Notes> notesList;
  const NotesGrid({
    super.key,
    required this.constrain,
    required this.notesSelected,
    required this.notesList,
  });

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: widget.notesList.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          maxCrossAxisExtent: widget.constrain.maxWidth * 0.3,
          childAspectRatio: 5 / 4,
        ),
        itemBuilder: (context, index) {
          return NotesGridTile(
            notes: widget.notesList[index],
            constrain: widget.constrain,
          );
        },
      ),
    );
  }
}
