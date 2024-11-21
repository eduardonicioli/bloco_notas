import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/note.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  // Lista de notas que simula um banco de dados
  List<Note> notes = [];

  NotesBloc() : super(NotesInitialState()) {
    on<AddNoteEvent>((event, emit) {
      // Adiciona a nova nota à lista
      notes.add(event.note);
      // Emite o novo estado com a lista de notas
      emit(NotesLoadedState(notes: notes));
    });

    on<DeleteNoteEvent>((event, emit) {
      // Remove a nota da lista baseado no id
      notes.removeWhere((note) => note.id == event.id);
      // Emite o estado com a lista de notas atualizada
      emit(NotesLoadedState(notes: notes));
    });

    on<EditNoteEvent>((event, emit) {
      // Atualiza a nota na lista baseado no id
      final index = notes.indexWhere((note) => note.id == event.note.id);
      if (index != -1) {
        notes[index] = event.note;
        emit(NotesLoadedState(notes: notes));
      }
    });
  }
}