import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note_app/db.dart';
// import 'package:flutter_note_app/db.dart';
import 'package:flutter_note_app/main.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActionsRow(),
          Align(
            alignment: Alignment.center,
            child: TextFormField( // Titre de la note
              maxLines: 1,
              initialValue: appState.n?.getTitle(),
              decoration: InputDecoration(labelText: "Title"),
              onChanged: (value) => appState.modifyTitle(value),
              inputFormatters: [
                LengthLimitingTextInputFormatter(100)
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TextFormField(
              maxLines: null,
              initialValue: appState.n?.getContent(),
              decoration: InputDecoration(labelText: "Content"),
              onChanged: (value) => appState.modifyContent(value),
              inputFormatters: [
                LengthLimitingTextInputFormatter(100)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NewNoteCard extends StatelessWidget {
  const NewNoteCard({super.key});

  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    
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
              maxLines: 1,
              decoration: InputDecoration(labelText: "Title"),
              onChanged: (value) => appState.modifyTitle(value),
              inputFormatters: [
                LengthLimitingTextInputFormatter(100)
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: "Content of the note"),
              onChanged: (value) => appState.modifyContent(value),
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
    DB db = DB.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox( // Back button
          height: boxSize,
          width: boxSize,
          child: FloatingActionButton(
            onPressed: () => {
              appState.accessNote(-1),
              appState.setNewNote()
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
              // print("Création de la note ${appState.n!.toMap()}"),
              if (appState.n!= null){
                db.insertNote(appState.n!.getTitle(), appState.n!.getContent()),
                appState.accessNote(-1),
                appState.setNewNote()
              },
            },
            tooltip: "Sauvegarder",
            child: Icon(Icons.check)
          ),
        ),

      ],
    );
  }
}

class ActionsRow extends StatelessWidget {
  const ActionsRow ({super.key});
  
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
    final boxSize = 40.0;
    DB db = DB.instance;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox( // Back button
          height: boxSize,
          width: boxSize,
          child: FloatingActionButton(
            onPressed: () => {
              if (appState.n != null){
                db.updateNote(appState.indexPage, appState.n!.getTitle(), appState.n!.getContent()),
              },
              appState.accessNote(-1),
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
              // print("Création de la note ${appState.n!.toMap()}"),
              if (appState.n!= null){
                db.deleteNote(appState.n!.getId()),
                appState.accessNote(-1),
              },
            },
            tooltip: "Supprimer",
            child: Icon(Icons.delete)
          ),
        ),

      ],
    );
  }
}