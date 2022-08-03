import 'package:flutter/material.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/widget/notes_list.dart';
import 'package:provider/provider.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage(
      {super.key, required this.selectListView, required this.isListView});
  final bool isListView;
  final Function selectListView;

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  Notes _selectedNotes = Notes();

  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).getAllNotes();
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
      final newNote = upDate(Notes(title: 'New Note'), context);
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
                    color: widget.isListView
                        ? Colors.orange.shade100
                        : Colors.white,
                    onPressed: () {
                      widget.selectListView(true);
                    },
                    icon: const Icon(
                      Icons.list,
                    ),
                    iconSize: 30,
                  ),
                  IconButton(
                    color: widget.isListView
                        ? Colors.orange.shade100
                        : Colors.white,
                    onPressed: () {
                      widget.selectListView(false);
                    },
                    icon: const Icon(
                      Icons.grid_view_rounded,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      newNote();
                    });
                  },
                  icon: const Icon(Icons.add_comment_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic_none),
                )
              ],
            ),
          ),
        ],
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
