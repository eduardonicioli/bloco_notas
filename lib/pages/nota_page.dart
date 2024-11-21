import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/nota_controller.dart';
import '../models/nota.dart';


class NotaPage extends StatefulWidget {
  @override
  _NotaPageState createState() => _NotaPageState();
}

class _NotaPageState extends State<NotaPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();
  final String? _id;

  _NotaPageState([this._id]);

  @override
  void initState() {
    super.initState();
    if (_id != null) {
      // Preencher os campos se for edição
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Nota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _conteudoController,
              decoration: InputDecoration(labelText: 'Conteúdo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final nota = Nota(
                  id: _id ?? DateTime.now().toString(),
                  titulo: _tituloController.text,
                  conteudo: _conteudoController.text,
                  dataCriacao: DateTime.now(),
                );
                if (_id == null) {
                  context.read<NotaController>().add(AdicionarNota(nota));
                } else {
                  context.read<NotaController>().add(EditarNota(nota));
                }
                Navigator.pop(context);
              },
              child: Text(_id == null ? 'Adicionar Nota' : 'Editar Nota'),
            ),
          ],
        ),
      ),
    );
  }
}
