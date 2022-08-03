import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:pangolin_notes/bloc/notes_bloc.dart';
import 'package:pangolin_notes/repository/notes_repository.dart';
import 'package:pangolin_notes/repository/notes_repository_impl.dart';
import 'package:pangolin_notes/screen/home_page.dart';
import 'package:pangolin_notes/service/objectbox_notes_service_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBoxNotesSevice.setup();
  final ObjectBoxNotesSevice notesSevice = ObjectBoxNotesSevice();
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.transparent,
  );
  runApp(PangolinNotes(notesSevice: notesSevice));
}

class PangolinNotes extends StatelessWidget {
  final ObjectBoxNotesSevice notesSevice;
  const PangolinNotes({required this.notesSevice, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pangolin Notes',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: TextTheme(
          titleLarge: const TextStyle(color: Colors.white),
          titleMedium: const TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.grey.shade300),
          bodyLarge: const TextStyle(color: Colors.white),
        ),
        canvasColor: Colors.transparent,
        primarySwatch: Colors.grey,
        backgroundColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: BlocProvider(
        create: (BuildContext context) => NotesBloc()..add(LoadNotesEvent()),
        child: const HomePage(),
      ),
    );
  }
}
