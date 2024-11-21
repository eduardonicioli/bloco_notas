import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notas')),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoadedState) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditNotePage(note: note),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<NotesBloc>(context)
                          .add(DeleteNoteEvent(note.id));
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
