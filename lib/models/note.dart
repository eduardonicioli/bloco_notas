class Note {
  final int id; // O id será um número inteiro gerado com base no tempo
  final String title;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  // Método para criar uma nova nota
  factory Note.create(String title, String content) {
    return Note(
      id: DateTime.now().millisecondsSinceEpoch, // ID gerado com base no tempo
      title: title,
      content: content,
    );
  }
}
