import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/nota_controller.dart';
import 'nota_page.dart';
import '../models/nota.dart';
import '../widgets/nota_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicativo de Notas'),
      ),
      body: BlocBuilder<NotaController, NotaState>(
        builder: (context, state) {
          if (state is NotasCarregadas) {
            return ListView.builder(
              itemCount: state.notas.length,
              itemBuilder: (context, index) {
                return NotaItem(nota: state.notas[index]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotaPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
