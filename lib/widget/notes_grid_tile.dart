import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:provider/provider.dart';

class NotesGridTile extends StatelessWidget {
  final Notes notes;
  final BoxConstraints constrain;

  const NotesGridTile({
    super.key,
    required this.notes,
    required this.constrain,
  });

  void upDateNotes(Notes notes, BuildContext context) {
    Provider.of<NotesProvider>(context, listen: false).saveNotes(notes);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: notes.materialColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  categoryColour(context, notes),
                  Expanded(
                    child: Container(
                      child: categoryField(context, notes),
                    ),
                  ),
                ],
              ),
              TextFormField(
                initialValue: notes.body,
                maxLines: constrain.maxHeight.toInt(),
                decoration: const InputDecoration(
                  hintText: 'Start Typing Here',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                style: Theme.of(context).textTheme.titleLarge,
                onChanged: (value) =>
                    upDateNotes(notes.copyWith(body: value), context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField categoryField(BuildContext context, Notes notes) {
    return TextFormField(
      cursorColor: Colors.white,
      showCursor: true,
      keyboardType: TextInputType.multiline,
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

  IconButton categoryColour(BuildContext context, Notes notes) {
    return IconButton(
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
