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
    // Carregar notas
    on<LoadNotesEvent>((event, emit) async {
      try {
        notes = await notesRepository.loadNotes();
        emit(NotesLoadedState(notes: notes));
      } catch (e) {
        emit(NotesErrorState());
      }
    });

    // Adicionar nota
    on<AddNoteEvent>((event, emit) async {
      notes.add(event.note); // Adiciona a nova nota na lista
      await notesRepository.saveNotes(notes); // Salva no repositório
      emit(NotesLoadedState(notes: notes)); // Emite o estado com a lista atualizada
    });


    // Excluir nota
    on<DeleteNoteEvent>((event, emit) async {
      notes.removeWhere((note) => note.id == event.id); // Remove a nota pelo ID
      await notesRepository.saveNotes(notes); // Salva no repositório
      emit(NotesLoadedState(notes: notes)); // Emite o estado com a lista atualizada
    });

    // Restaurar nota excluída
    on<RestoreNoteEvent>((event, emit) async {
      notes.insert(event.index, event.note); // Insere a nota de volta na posição original
      await notesRepository.saveNotes(notes); // Salva a lista atualizada no repositório
      emit(NotesLoadedState(notes: notes)); // Emite o estado com a lista atualizada
    });


    // Editar nota existente
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
