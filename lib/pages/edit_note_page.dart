import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../models/note.dart';

class EditNotePage extends StatelessWidget {
  final Note note;

  EditNotePage({required this.note});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    contentController.text = note.content;

    return Scaffold(
      appBar: AppBar(title: Text('Editar Nota')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de título
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),

            // Campo de conteúdo com rolagem e maxLines = null
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: contentController,
                  maxLines: 20,  // Sem limite de linhas
                  decoration: InputDecoration(
                    labelText: 'Conteúdo',
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),

            // Botão de salvar
            ElevatedButton(
              onPressed: () {
                final updatedNote = Note(
                  id: note.id,
                  title: titleController.text,
                  content: contentController.text,
                );
                BlocProvider.of<NotesBloc>(context)
                    .add(EditNoteEvent(updatedNote));
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
