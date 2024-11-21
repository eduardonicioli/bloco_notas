import '../models/note.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<Note> notes;

  NotesLoadedState({required this.notes});
}
