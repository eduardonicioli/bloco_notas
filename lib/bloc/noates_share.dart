import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// Função para gerar e compartilhar o arquivo TXT
Future<void> shareNoteAsTxt(String title, String content) async {
  try {
    // Diretório temporário
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/nota.txt';

    // Criar conteúdo
    final fileContent = "Título: $title\n\nConteúdo:\n$content";

    // Criar o arquivo TXT
    final file = File(filePath);
    await file.writeAsString(fileContent);

    // Compartilhar o arquivo
    await Share.shareXFiles(
      [XFile(filePath)], // Criação de um objeto XFile
      text: 'Compartilhando uma nota!',
    );
  } catch (e) {
    print('Erro ao compartilhar nota: $e');
  }
}
