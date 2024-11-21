import '../models/note.dart';

abstract class NotesEvent {}

class AddNoteEvent extends NotesEvent {
  final Note note;

  AddNoteEvent(this.note);
}

class EditNoteEvent extends NotesEvent {
  final Note note;

  EditNoteEvent(this.note);
}

class DeleteNoteEvent extends NotesEvent {
  final int id;

  DeleteNoteEvent(this.id);
}
