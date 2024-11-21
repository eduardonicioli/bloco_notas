// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/notes_bloc.dart';
import 'repositories/notes_repository.dart';
import 'pages/home_page.dart';
import 'package:bloco_notas/bloc/notes_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NotesRepository notesRepository = NotesRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(notesRepository)..add(LoadNotesEvent()),
      child: MaterialApp(
        title: 'Bloco de Notas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
