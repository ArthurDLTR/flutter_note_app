import 'package:flutter/material.dart';

class PreviewNoteCard extends StatelessWidget {

  const PreviewNoteCard({super.key});

  @override
  Widget build(BuildContext context){

    const cardPadding = 5.0;

    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText( // First, the title of the note in bold style and bigger
              text: TextSpan(
                text: "Titre de la note",
                style: TextStyle(fontWeight: FontWeight.bold, )// fontSize: MediaQuery.of(context).size.width * 1.5 )
              ),
              textAlign: TextAlign.left,
            ),
            RichText( // Then, a preview of the note with the first lines
              text: TextSpan(
                text: "Aperçu du contenu de la note en plus clair et plus petit",
                style: TextStyle(fontWeight: FontWeight.w100,) // fontSize: MediaQuery.of(context).size.width * 0.5)
              ),
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}