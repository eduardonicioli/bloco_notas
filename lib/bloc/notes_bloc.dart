// lib/bloc/notes_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/note.dart';
import '../repositories/notes_repository.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository;
  List<Note> notes = [];

  NotesBloc(this.notesRepository) : super(NotesInitialState()) {
    on<LoadNotesEvent>((event, emit) async {
      try {
        notes = await notesRepository.loadNotes();
        emit(NotesLoadedState(notes: notes));
      } catch (e) {
        emit(NotesErrorState());
      }
    });

    on<AddNoteEvent>((event, emit) async {
      notes.add(event.note);
      await notesRepository.saveNotes(notes);
      emit(NotesLoadedState(notes: notes));
    });

    on<DeleteNoteEvent>((event, emit) async {
      notes.removeWhere((note) => note.id == event.id);
      await notesRepository.saveNotes(notes);
      emit(NotesLoadedState(notes: notes));
    });

    on<RestoreNoteEvent>((event, emit) {
      if (state is NotesLoadedState) {
        final currentState = state as NotesLoadedState;
        final updatedNotes = List<Note>.from(currentState.notes);
        updatedNotes.insert(event.index, event.note); // Insere na posição original
        emit(NotesLoadedState(notes: updatedNotes));
      }
    });

    on<EditNoteEvent>((event, emit) async {
      final index = notes.indexWhere((note) => note.id == event.note.id);
      if (index != -1) {
        notes[index] = event.note;
        await notesRepository.saveNotes(notes);
        emit(NotesLoadedState(notes: notes));
      }
    });
  }
}
