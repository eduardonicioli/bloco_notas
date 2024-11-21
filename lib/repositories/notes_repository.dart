// lib/repositories/notes_repository.dart
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/note.dart';

class NotesRepository {
  // Método para obter o diretório de documentos
  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Carregar as notas de um arquivo JSON
  Future<List<Note>> loadNotes() async {
    final path = await _getLocalPath();
    final file = File('$path/notes.json');

    if (await file.exists()) {
      String content = await file.readAsString();
      List<dynamic> decodedNotes = json.decode(content);
      return decodedNotes.map((note) => Note.fromJson(note)).toList();
    }

    return [];  // Retorna uma lista vazia se não houver notas
  }

  // Salvar as notas em um arquivo JSON
  Future<void> saveNotes(List<Note> notes) async {
    final path = await _getLocalPath();
    final file = File('$path/notes.json');

    String notesJson = json.encode(notes.map((note) => note.toJson()).toList());
    await file.writeAsString(notesJson);
  }
}
