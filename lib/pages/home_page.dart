import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';
import 'package:bloco_notas/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'aNota!',
        backgroundColor: Colors.red,
      ),
      body: GradientBackground(
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoadedState) {
              if (state.notes.isEmpty) {
                return Center(
                  child: Text(
                    "Nenhuma nota por aqui!\nAdicione uma nova nota.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.red),
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
                  final contentLines = note.content.split("\n").take(1).join("\n");

                  return ListTile(
                    title: Text(
                      note.title.isEmpty ? "Título (em branco)" : note.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.content.isEmpty ? "Conteúdo (em branco)" : contentLines,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5), // Adiciona um pequeno espaço entre o conteúdo e a data
                        Text(
                          'Criado em: $formattedDate',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Divider(
                          color: Colors.grey, // Cor do divisor
                          thickness: 1,        // Espessura do divisor
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
