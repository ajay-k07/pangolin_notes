import 'package:flutter/material.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/screen/settings.dart';
import 'package:pangolin_notes/service/objectbox_notes_service_impl.dart';
import 'package:pangolin_notes/widget/notes_list.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> with WindowListener {
  Notes _selectedNotes = Notes();

  final TextEditingController _controller = TextEditingController();

  void getAllNotes() {
    Provider.of<NotesProvider>(context, listen: false).getAllNotes();
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    getAllNotes();
  }

  @override
  void dispose() {
    super.dispose();
    windowManager.removeListener(this);
  }

  @override
  void onWindowClose() {
    final note = _selectedNotes.copyWith(body: _controller.text);
    upDate(note, context);
    ObjectBoxNotesSevice.close();
  }

  Notes upDate(Notes notes, BuildContext context) {
    return Provider.of<NotesProvider>(context, listen: false).saveNotes(notes);
  }

  void newNote() {
    setState(() {
      final oldNote = _selectedNotes.copyWith(body: _controller.text);
      if (oldNote.body!.isNotEmpty) {
        upDate(oldNote, context);
      }
      final newNote = upDate(Notes(), context);
      _selectedNotes = newNote;
      _controller.text = _selectedNotes.body!;
    });
  }

  void notesSelected(Notes notes) {
    final old = _selectedNotes.copyWith(
      body: _controller.text,
    );
    if (_selectedNotes != old) {
      upDate(old, context);
    }
    setState(() {
      _selectedNotes = notes;
      _controller.text = notes.body!;
    });
  }

  void deletedNode() {
    setState(() {
      final newNode = Notes();
      _selectedNotes = newNode;
      _controller.text = newNode.body!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      newNote();
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                    iconSize: 30,
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, SettingsPage.routeName);
                    },
                    icon: const Icon(
                      Icons.settings,
                    ),
                    iconSize: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: Consumer<NotesProvider>(
        builder: (context, value, child) {
          return SizedBox(
            child: LayoutBuilder(
              builder: (context, constrain) {
                return Row(
                  children: [
                    Column(
                      children: [
                        NotesList(
                          constrain: constrain,
                          value: value,
                          notesSelected: notesSelected,
                          deletedNote: deletedNode,
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        key: const Key('EDIT_NOTE_TEXT_FORM_FIELD'),
                        style: Theme.of(context).textTheme.bodyLarge,
                        controller: _controller,
                        maxLines: constrain.maxHeight.toInt(),
                        decoration: const InputDecoration(
                          hintText: 'Start Typing Here',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
