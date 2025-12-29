import 'package:flutter/material.dart';
// import 'package:flutter_note_app/db.dart';
import 'package:flutter_note_app/main.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context){
    // var appState = context.watch<MyAppState>();

    // DB db = DB();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonsRow(),
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
      ),
    );
  }
}

class NewNoteCard extends StatelessWidget {
  const NewNoteCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ButtonsRow(),
          Align(
            alignment: Alignment.center,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Title"),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              decoration: InputDecoration(labelText: "Content of the note"),
            )
          )
        ],
      ),
    );
  }
}

class ButtonsRow extends StatelessWidget {
  const ButtonsRow ({super.key});
  
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    final boxSize = 40.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox( // Back button
          height: boxSize,
          width: boxSize,
          child: FloatingActionButton(
            onPressed: () => {
              appState.accessNote(-1)
            },
            tooltip: "Retour",
            child: Icon(Icons.close)
          ),
        ),
        SizedBox( // Validate/Save button
          height: boxSize,
          width: boxSize,
          child: FloatingActionButton(
            onPressed: () => {
              print("Sauvegarde")
            },
            tooltip: "Sauvegarder",
            child: Icon(Icons.check)
          ),
        ),

      ],
    );
  }
}