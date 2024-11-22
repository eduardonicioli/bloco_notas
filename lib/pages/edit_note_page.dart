import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../models/note.dart';
import 'package:bloco_notas/widgets.dart';

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
      appBar: customAppBar(
        title: 'Editar Nota',
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
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
                BlocProvider.of<NotesBloc>(context).add(EditNoteEvent(updatedNote));
                Navigator.pop(context); // Volta para a página anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Cor de fundo
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Tamanho do botão
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white), // Ícone de voltar
                  SizedBox(width: 5), // Espaço entre o ícone e o texto
                  Text(
                    'Salvar e Voltar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
