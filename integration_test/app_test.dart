import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/repository/notes_repository_impl.dart';
import 'package:pangolin_notes/screen/list_view_page.dart';
import 'package:pangolin_notes/screen/settings.dart';
import 'package:pangolin_notes/service/settings_service_impl.dart';
import 'package:provider/provider.dart';
import 'package:integration_test/integration_test.dart';

class MockSharedPreefSettingsService extends Mock
    implements SharedPrefSettingsService {}

class MockNotesRepoImpl extends Mock implements NotesRepoImpl {}

class MockNotes extends Mock implements Notes {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late MockNotesRepoImpl mockNotesRepoImpl;

  late Widget widgetToTest;
  var notesList = [
    Notes(
      id: 1,
      title: 'title 1',
      body: 'body 1',
      category: 'category 1',
    ),
    Notes(
      id: 2,
      title: 'title 2',
      body: 'body 2',
      category: 'category 2',
    ),
    Notes(
      id: 3,
      title: 'title 3',
      body: 'body 3',
      category: 'category 3',
    ),
  ];

  final noteToUpdate = Notes(
    id: 2,
    title: 'title 2',
    body: 'body 2',
    category: 'category 2',
  );

  setUpAll(() {
    registerFallbackValue(Notes(id: 2));
  });

  setUp(() async {
    mockNotesRepoImpl = MockNotesRepoImpl();
    when(() => mockNotesRepoImpl.getAllNotes()).thenAnswer((invocation) {
      return [...notesList];
    });

    when(() => mockNotesRepoImpl.saveNotes(note: any(named: 'note')))
        .thenAnswer((invocation) {
      Notes localnote = invocation.namedArguments[Symbol('note')] as Notes;
      if (localnote.id == 0) {
        localnote = localnote.copyWith(id: notesList.length + 1);
      }
      notesList.add(localnote);
      return localnote.id!;
    });

    when(() => mockNotesRepoImpl.updateNotes(note: any(named: 'note')))
        .thenAnswer((invocation) {
      Notes localnote = invocation.namedArguments[Symbol('note')] as Notes;

      notesList[notesList.indexWhere((element) => element.id == localnote.id)] =
          localnote;
      return localnote.id!;
    });

    when(() => mockNotesRepoImpl.deleteNotes(id: any<int>(named: 'id')))
        .thenAnswer((invocation) {
      int id = invocation.namedArguments[Symbol('id')];
      notesList.removeWhere((element) => element.id == id);
      return true;
    });
    widgetToTest = MaterialApp(
      routes: {
        '/': (context) => Scaffold(
              body: ChangeNotifierProvider(
                create: (context) => NotesProvider(mockNotesRepoImpl),
                child: const ListViewPage(),
              ),
            ),
        SettingsPage.routeName: (context) => const SettingsPage()
      },
    );
  });
  group('app test', () {
    testWidgets('Tap Notes Check', (tester) async {
      await tester.pumpWidget(widgetToTest);
      final note = notesList.first;
      await tester.tap(find.text(note.title!));
      expect(find.text(note.body!), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('check is edit saved', (tester) async {
      await tester.pumpWidget(widgetToTest);

      final note = noteToUpdate;

      await tester.tap(find.text(note.title!));
      await tester.pumpAndSettle();

      final formfield = find.byKey(Key('EDIT_NOTE_TEXT_FORM_FIELD'));

      final inputText = 'new body 2';

      await tester.enterText(formfield, inputText);

      await tester.pumpAndSettle();
      expect(find.text(inputText), findsOneWidget);

      final lastNote = notesList.last;

      await tester.tap(find.text(lastNote.title!));
      await tester.pumpAndSettle();
      expect(find.text(lastNote.body!), findsOneWidget);

      expect(find.text('new body 2'), findsOneWidget);
    });

    testWidgets('add new note', (tester) async {
      await tester.pumpWidget(widgetToTest);
      final formfield = find.byKey(Key('EDIT_NOTE_TEXT_FORM_FIELD'));

      final inputText = 'new note created';
      await tester.enterText(formfield, inputText);
      await tester.pumpAndSettle();
      expect(find.text(inputText), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text(inputText), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 5));
    });

    testWidgets('delete note', (tester) async {
      await tester.pumpWidget(widgetToTest);
      final formfield = find.byKey(Key('EDIT_NOTE_TEXT_FORM_FIELD'));

      final inputText = 'delete note test';
      await tester.enterText(formfield, inputText);
      await tester.pumpAndSettle();
      expect(find.text(inputText), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(find.text(inputText), findsOneWidget);
      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.tap(find.byIcon(Icons.delete).last);
      await tester.pumpAndSettle();

      for (Notes notes in notesList) {
        expect(find.text(notes.title!), findsOneWidget);
      }

      await tester.pumpAndSettle(Duration(seconds: 5));
    });

    testWidgets('go to settings page and come back to main page',
        (tester) async {
      await tester.pumpWidget(widgetToTest);

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(ListViewPage), findsNothing);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsNothing);
      expect(find.byType(ListViewPage), findsOneWidget);
    });
  });
}
