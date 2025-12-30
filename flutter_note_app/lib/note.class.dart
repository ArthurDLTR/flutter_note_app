// import 'package:flutter_note_app/db.dart';

class Note {
  final int id;
  String titre = "";
  String contenu = "";

  Note({required this.id});
  Note.complete(this.id, String title, String content) {
    titre = title;
    contenu = content;
  }

  int getId() => id;

  void setTitle (String title) => titre = title;
  String getTitle () => titre;

  void setContent (String content) => contenu = content;
  String getContent () => contenu;

  Map<String, Object?> toMap() {
    return {'id': id, 'titre': titre, 'contenu': contenu};
  }
}