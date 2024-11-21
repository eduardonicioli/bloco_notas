import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import '../models/note.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';
import 'package:bloco_notas/widgets.dart';  // Certifique-se de importar corretamente o widgets.dart

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(  // Usando a custom AppBar
        title: 'Notas',
        backgroundColor: Colors.redAccent,  // Exemplo de cor personalizada
      ),
      body: GradientBackground(
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoadedState) {
              if (state.notes.isEmpty) {
                return Center(
                  child: Text(
                    "Nenhuma nota disponível.\nAdicione uma nova nota.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  final note = state.notes[index];
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(note.id));
                  final formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} "
                      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                  final contentLines = note.content.split("\n").take(3).join("\n");

                  return ListTile(
                    title: Text(
                      note.title.isEmpty ? "Título (em branco)" : note.title,
                      style: TextStyle(
                        color: Colors.redAccent, // Cor do título
                        fontWeight: FontWeight.bold, // Deixa o título em negrito (opcional)
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.content.isEmpty ? "Conteúdo (em branco)" : contentLines,
                          style: TextStyle(
                            color: Colors.black54, // Cor do conteúdo
                            fontSize: 14, // Tamanho da fonte (opcional)
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Criado em: $formattedDate', // Data e hora formatada
                          style: TextStyle(
                            color: Colors.white, // Cor da data
                            fontSize: 12, // Tamanho da fonte
                          ),
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNotePage(note: note),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Deleta a nota ao pressionar o ícone
                        BlocProvider.of<NotesBloc>(context).add(DeleteNoteEvent(note.id));
                      },
                    ),
                  );

                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
