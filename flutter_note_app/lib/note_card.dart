import 'package:flutter/material.dart';
import 'package:flutter_note_app/main.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => {
            appState.accessNote(-1)
          },
          child: Icon(Icons.close)
          ),
        Align(
          alignment: Alignment.center,
          child: RichText( // Titre de la note
            text: TextSpan(
              text: "Titre de la note $index",
              style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 242, 242, 242), fontSize: 24),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: "Contenu complet de la page",
              style:  TextStyle(color: Color.fromARGB(255, 242, 242, 242)),
            ),
          ),
        )
      ],
    );
  }
}