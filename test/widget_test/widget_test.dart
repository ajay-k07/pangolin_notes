// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:mocktail/mocktail.dart';
import 'package:pangolin_notes/Provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pangolin_notes/model/notes.dart';
import 'package:pangolin_notes/repository/notes_repository_impl.dart';
import 'package:pangolin_notes/screen/list_view_page.dart';
import 'package:pangolin_notes/service/settings_service_impl.dart';
import 'package:provider/provider.dart';

class MockSharedPreefSettingsService extends Mock
    implements SharedPrefSettingsService {}

class MockNotesRepoImpl extends Mock implements NotesRepoImpl {}

void main() {
  late MockNotesRepoImpl mockNotesRepoImpl;
  late Widget widgetToTest;
  final notesList = [
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
  setUp(() async {
    mockNotesRepoImpl = MockNotesRepoImpl();
    when(() => mockNotesRepoImpl.getAllNotes()).thenReturn([...notesList]);
    widgetToTest = MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => NotesProvider(mockNotesRepoImpl),
            child: const ListViewPage()),
      ),
    );
  });

  group('Home Page Test', () {
    testWidgets(
      'App bar Test',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetToTest);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      },
    );

    testWidgets(
      'Left Panel Test',
      (widgetTester) async {
        await widgetTester.pumpWidget(widgetToTest);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(ListTile), findsNWidgets(notesList.length));
        for (Notes note in notesList) {
          expect(find.text(note.title!), findsOneWidget);
          //         final EditableText formfield =
          //  widgetTester.widget<EditableText>(find.byKey(Key(note.id.toString())));
          //final textfield = (TextFormField) find.byKey(Key(note.id.toString())).evaluate().first.widget;
          expect(find.text(note.category!), findsOneWidget);
          expect(find.byKey(Key('${note.id}-colour-category-key')),
              findsOneWidget);
          find.byType(ListTile).first.hitTestable();
        }

        expect(find.byIcon(Icons.delete), findsNWidgets(notesList.length));
      },
    );
    testWidgets('Test The Right Side', (tester) async {
      await tester.pumpWidget(widgetToTest);
      expect(
          find.byKey(const Key('EDIT_NOTE_TEXT_FORM_FIELD')), findsOneWidget);
    });
  });
}
