import 'package:flutter/material.dart';
import '../models/nota.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/nota_controller.dart';


class NotaItem extends StatelessWidget {
  final Nota nota;

  NotaItem({required this.nota});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nota.titulo),
      subtitle: Text(nota.conteudo),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          context.read<NotaController>().add(ExcluirNota(nota.id));
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotaPage(nota.id),
          ),
        );
      },
    );
  }
}
