import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../models/note.dart';
import 'package:bloco_notas/widgets.dart';

class AddNotePage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Adicionar Nota',
        backgroundColor: Colors.green,
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
                  id: DateTime.now().millisecondsSinceEpoch.toString(),  // Converte o 'int' para 'String'
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
