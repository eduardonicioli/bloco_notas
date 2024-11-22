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

            // Botões de Voltar e Salvar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão Voltar
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Apenas volta para a página anterior
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Cor de fundo
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Tamanho do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white), // Ícone
                      SizedBox(width: 5),
                      Text(
                        'Voltar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Cor do texto
                        ),
                      ),
                    ],
                  ),
                ),

                // Botão Salvar
                ElevatedButton(
                  onPressed: () {
                    // Criar uma nova nota
                    final newNote = Note(
                      id: DateTime.now().millisecondsSinceEpoch.toString(), // Converte o 'int' para 'String'
                      title: titleController.text,
                      content: contentController.text,
                    );

                    // Disparar o evento AddNoteEvent para adicionar a nota
                    BlocProvider.of<NotesBloc>(context).add(AddNoteEvent(newNote));

                    // Voltar para a página anterior
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Cor de fundo
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Tamanho do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check, color: Colors.white), // Ícone
                      SizedBox(width: 5),
                      Text(
                        'Salvar',
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
          ],
        ),
      ),
    );
  }
}
