import 'package:bloco_notas/models/note.dart';  // Importando Note corretamente.
import 'package:meta/meta.dart';


abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<Note> notes;
  NotesLoadedState({required this.notes});
}

class NotesErrorState extends NotesState {}