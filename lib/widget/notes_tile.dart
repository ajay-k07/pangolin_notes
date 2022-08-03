// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:provider/provider.dart';

class NotesTile extends StatelessWidget {
  final Function selectedNote;
  final Function deletedNote;

  NotesTile({
    Key? key,
    required this.selectedNote,
    required this.notes,
    required this.deletedNote,
  }) : super(key: key);

  final Notes notes;
  final FocusNode categoryFocusNode = FocusNode();
  void upDateNotes(Notes notes, BuildContext context) {
    Provider.of<NotesProvider>(context, listen: false).saveNotes(notes);
  }

  void deleteNotes(Notes notes, BuildContext context) {
    Provider.of<NotesProvider>(context, listen: false).deleteNotes(notes);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: notes.materialColor.withOpacity(0.1),
      leading: categoryColour(context),
      onTap: () => selectedNote(notes),
      title: Text(
        notes.title!,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: categoryField(context),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red.shade500,
        ),
        onPressed: () {
          deleteNotes(notes, context);
        },
      ),
    );
  }

  TextFormField categoryField(BuildContext context) {
    return TextFormField(
      key: Key(notes.id.toString()),
      style: Theme.of(context).textTheme.titleSmall,
      initialValue: notes.category,
      onChanged: (value) {
        upDateNotes(notes.copyWith(category: value), context);
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  IconButton categoryColour(BuildContext context) {
    return IconButton(
      key: Key('${notes.id}-colour-category-key'),
      icon: Icon(
        Icons.circle,
        size: 20,
        shadows: const [Shadow(color: Colors.white, blurRadius: 1)],
        color: notes.materialColor,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (localcontext) {
            return Dialog(
              child: MaterialPicker(
                pickerColor: notes.materialColor,
                onColorChanged: (value) => upDateNotes(
                  notes.copyWith(color: value.value.toString()),
                  context,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
