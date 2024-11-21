import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../models/note.dart';

class AddNotePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Nota'),
      ),
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

            // Campo de conteúdo
            TextField(
              controller: contentController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Conteúdo',
                alignLabelWithHint: true,
                labelStyle: TextStyle(fontSize: 16),
              ),
            ),

            Expanded(child: Container()),

            // Botão de salvar
            ElevatedButton(
              onPressed: () {
                // Criar uma nova nota
                final newNote = Note(
                  id: DateTime.now().millisecondsSinceEpoch,  // Gerando um id único baseado no tempo
                  title: titleController.text,
                  content: contentController.text,
                );

                // Disparar o evento AddNoteEvent para adicionar a nota
                BlocProvider.of<NotesBloc>(context).add(AddNoteEvent(newNote));

                // Voltar para a página anterior
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
