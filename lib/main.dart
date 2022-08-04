import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/Provider/settings_provider.dart';
import 'package:pangolin_notes/repository/notes_repository.dart';
import 'package:pangolin_notes/repository/notes_repository_impl.dart';
import 'package:pangolin_notes/screen/list_view_page.dart';
import 'package:pangolin_notes/screen/onboarding/on_boarding_screen.dart';
import 'package:pangolin_notes/screen/settings.dart';
import 'package:pangolin_notes/service/objectbox_notes_service_impl.dart';
import 'package:pangolin_notes/service/settings_service_impl.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBoxNotesSevice.setup();
  await SharedPrefSettingsService.setup();
  final ObjectBoxNotesSevice notesSevice = ObjectBoxNotesSevice();
  final NotesRepository notesRepository =
      NotesRepoImpl(notesSevice: notesSevice);
  final SharedPrefSettingsService settingsService = SharedPrefSettingsService();
  await Window.initialize();
  await windowManager.ensureInitialized();
  const WindowOptions windowOptions =
      WindowOptions(size: Size(1200, 800), minimumSize: Size(800, 600));
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  await Window.setEffect(
    effect: settingsService.getWindowEffect(),
  );
  runApp(MyProviderClass(
      notesRepository: notesRepository, settingsService: settingsService));
}

class MyProviderClass extends StatelessWidget {
  final NotesRepository notesRepository;
  final SharedPrefSettingsService settingsService;
  const MyProviderClass({
    super.key,
    required this.notesRepository,
    required this.settingsService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(notesRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsProvider(settingsService),
        )
      ],
      child: const PangolinNotes(),
    );
  }
}

class PangolinNotes extends StatefulWidget {
  const PangolinNotes({
    Key? key,
  }) : super(key: key);

  @override
  State<PangolinNotes> createState() => _PangolinNotesState();
}

class _PangolinNotesState extends State<PangolinNotes> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, value, child) => MaterialApp(
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
        home: value.showOnboarding
            ? const OnBoardingPage()
            : const ListViewPage(),
        routes: {SettingsPage.routeName: (context) => const SettingsPage()},
      ),
    );
  }
}
