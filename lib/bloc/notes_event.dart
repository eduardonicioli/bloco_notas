import 'package:bloco_notas/models/note.dart';

abstract class NotesEvent {}

class LoadNotesEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final Note note;
  AddNoteEvent(this.note);
}

class DeleteNoteEvent extends NotesEvent {
  final String id;
  DeleteNoteEvent(this.id);
}

class EditNoteEvent extends NotesEvent {
  final Note note;
  EditNoteEvent(this.note);
}