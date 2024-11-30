import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../models/note.dart';
import 'package:bloco_notas/widgets.dart';
import 'dart:async';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String? errorMessage; // Para exibir a mensagem de erro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite redimensionar a tela ao exibir o teclado
      appBar: customAppBar(
        title: 'Adicionar Nota',
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Conteúdo principal
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: 'Título',
                            labelStyle: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: contentController,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Conteúdo',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Volta para a página anterior
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back, color: Colors.white),
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
                    ElevatedButton(
                      onPressed: () {
                        // Valida os campos antes de salvar
                        if (titleController.text.isEmpty ||
                            contentController.text.isEmpty) {
                          // Atualiza a mensagem de erro
                          setState(() {
                            errorMessage = 'Preencha todos os campos!';
                          });
                          Timer(Duration(seconds: 1), (){
                            setState(() {
                              errorMessage = null;
                            });
                          });
                          return;
                        }

                        // Cria uma nova nota
                        final newNote = Note(
                          id: DateTime.now().millisecondsSinceEpoch.toString(), // Gera um ID único
                          title: titleController.text,
                          content: contentController.text,
                        );

                        // Dispara o evento AddNoteEvent
                        BlocProvider.of<NotesBloc>(context).add(AddNoteEvent(newNote));

                        // Limpa a mensagem de erro, se existir
                        setState(() {
                          errorMessage = null;
                        });

                        // Exibe um snackbar de sucesso
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Nota adicionada com sucesso!'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          ),
                        );

                        Future.delayed(Duration(seconds: 0), () {
                          Navigator.pop(context); // Volta para a página anterior
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check, color: Colors.white),
                          SizedBox(width: 3),
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
          // Mensagem de erro
          if (errorMessage != null)
            Positioned(
              bottom: 80, // Exibe acima dos botões
              left: 16,
              right: 16,
              child: Material(
                elevation: 2,
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
