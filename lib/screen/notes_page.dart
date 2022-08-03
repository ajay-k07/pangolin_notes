import 'package:flutter/material.dart';

import 'package:pangolin_notes/screen/list_view_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _isListView = true;
  void selectListView(bool value) {
    setState(() {
      _isListView = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListViewPage(
        selectListView: selectListView,
        isListView: _isListView,
      ),
    );
  }
}
