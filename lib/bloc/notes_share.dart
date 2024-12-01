import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

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
