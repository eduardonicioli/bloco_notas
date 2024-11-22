import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';
import 'package:bloco_notas/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAscending = true; // Controle da ordem de classificação

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'aNota!',
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                isAscending = value == 'Crescente';
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Crescente',
                child: Text('Ordenar Crescente'),
              ),
              PopupMenuItem(
                value: 'Decrescente',
                child: Text('Ordenar Decrescente'),
              ),
            ],
            icon: Icon(Icons.sort, color: Colors.white),
          ),
        ],
      ),
      body: GradientBackground(
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoadedState) {
              // Ordenar as notas com base no estado `isAscending`
              final notes = [...state.notes];
              notes.sort((a, b) {
                final dateA = DateTime.fromMillisecondsSinceEpoch(int.parse(a.id));
                final dateB = DateTime.fromMillisecondsSinceEpoch(int.parse(b.id));
                return isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
              });

              if (notes.isEmpty) {
                return Center(
                  child: Text(
                    "Nenhuma nota por aqui!\nAdicione uma nova nota.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                );
              }

              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
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
                        final deletedNote = note;
                        BlocProvider.of<NotesBloc>(context).add(DeleteNoteEvent(note.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Nota excluída'),
                            action: SnackBarAction(
                              label: 'Desfazer',
                              onPressed: () {
                                BlocProvider.of<NotesBloc>(context).add(AddNoteEvent(deletedNote));
                              },
                            ),
                            duration: Duration(seconds: 5),
                          ),
                        );
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(),
            ),
          );
        },
        label: Text(
          'Nova Nota',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        icon: Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
    );
  }
}
