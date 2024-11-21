import 'package:flutter_bloc/flutter_bloc.dart';
import 'notes_event.dart';
import 'notes_state.dart';
import '../models/note.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial());

  List<Note> notes = [];

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    if (event is AddNoteEvent) {
      notes.add(event.note);
      yield NotesLoadedState(notes);
    } else if (event is EditNoteEvent) {
      int index = notes.indexWhere((note) => note.id == event.note.id);
      if (index != -1) {
        notes[index] = event.note;
        yield NotesLoadedState(notes);
      }
    } else if (event is DeleteNoteEvent) {
      notes.removeWhere((note) => note.id == event.id);
      yield NotesLoadedState(notes);
    }
  }
}
