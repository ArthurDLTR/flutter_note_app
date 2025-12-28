class Note {
  final int id;
  final String titre;
  final String contenu;

  const Note({required this.id, required this.titre, required this.contenu});

  Map<String, Object?> toMap() {
    return {'id': id, 'titre': titre, 'contenu': contenu};
  }
}