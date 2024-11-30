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
    // Preenche os controladores com os valores da nota
    titleController.text = note.title;
    contentController.text = note.content;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite redimensionar a tela ao exibir o teclado
      appBar: customAppBar(
        title: 'Editar Nota',
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Conteúdo da tela rolável
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                    SizedBox(height: 10),

                    // Campo de conteúdo
                    TextField(
                      controller: contentController,
                      maxLines: null, // Permite várias linhas
                      decoration: InputDecoration(
                        labelText: 'Conteúdo',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20), // Espaço entre os campos e os botões
                  ],
                ),
              ),
            ),
          ),

          // Botões de Voltar e Salvar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão Voltar
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Volta para a página anterior
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Cor de fundo
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Botão Salvar
                ElevatedButton(
                  onPressed: () {
                    // Valida os campos antes de salvar
                    if (titleController.text.isEmpty ||
                        contentController.text.isEmpty) {
                      // Exibe um snackbar se algum campo estiver vazio
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Preencha todos os campos!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Atualiza a nota com os novos valores
                    final updatedNote = Note(
                      id: note.id, // Mantém o ID original
                      title: titleController.text,
                      content: contentController.text,
                    );

                    // Dispara o evento EditNoteEvent
                    BlocProvider.of<NotesBloc>(context)
                        .add(EditNoteEvent(updatedNote));

                    // Exibe um snackbar de sucesso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nota editada com sucesso!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                      ),
                    );

                    // Volta para a página anterior
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Cor de fundo
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
