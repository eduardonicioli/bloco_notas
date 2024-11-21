import '../models/note.dart';

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<Note> notes;

  NotesLoadedState(this.notes);
}
