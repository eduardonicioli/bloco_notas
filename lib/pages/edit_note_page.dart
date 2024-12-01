import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../models/note.dart';
import 'package:bloco_notas/widgets.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw; // Importação da biblioteca PDF


class EditNotePage extends StatelessWidget {
  final Note note;

  EditNotePage({required this.note});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // Função para compartilhar a nota como PDF
  Future<void> shareNoteAsPdf(BuildContext context, String title, String content) async {
    try {
      // Criar um documento PDF
      final pdf = pw.Document();

      // Adicionar uma página com o conteúdo da nota
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title.isNotEmpty ? title : 'Sem título',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(content.isNotEmpty ? content : 'Sem conteúdo'),
            ],
          ),
        ),
      );

      // Obter o diretório temporário
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/nota.pdf';

      // Salvar o PDF no diretório
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Compartilhar o arquivo PDF
      await Share.shareXFiles(
        [XFile(filePath)], // Criação de um objeto XFile
        text: 'Compartilhando uma nota!',
      );
    } catch (e) {
      // Mostra uma mensagem de erro se algo der errado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao compartilhar a nota.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Erro ao compartilhar nota: $e');
    }
  }

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

          // Botões de Voltar, Compartilhar e Salvar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão Voltar
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Volta para a página anterior
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // Cor de fundo
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02, // Ajustável
                        vertical: MediaQuery.of(context).size.height * 0.01, // Ajustável
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white), // Ícone
                        SizedBox(width: 4),
                        Text(
                          'Voltar',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035, // Ajustável
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.02), // Espaço entre botões

                // Botão Compartilhar
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      shareNoteAsPdf(
                        context,
                        titleController.text.isEmpty ? "Sem título" : titleController.text,
                        contentController.text.isEmpty ? "Sem conteúdo" : contentController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Cor de fundo
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02, // Ajustável
                        vertical: MediaQuery.of(context).size.height * 0.01, // Ajustável
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, color: Colors.white), // Ícone
                        SizedBox(width: 4),
                        Text(
                          'Compar...',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035, // Ajustável
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: MediaQuery.of(context).size.width * 0.02), // Espaço entre botões

                // Botão Salvar
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isEmpty || contentController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Preencha todos os campos!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final updatedNote = Note(
                        id: note.id,
                        title: titleController.text,
                        content: contentController.text,
                      );

                      BlocProvider.of<NotesBloc>(context).add(EditNoteEvent(updatedNote));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nota editada com sucesso!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cor de fundo
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02, // Ajustável
                        vertical: MediaQuery.of(context).size.height * 0.01, // Ajustável
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check, color: Colors.white), // Ícone
                        SizedBox(width: 5),
                        Text(
                          'Salvar',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035, // Ajustável
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
