import 'package:flutter/material.dart';

class PreviewNoteCard extends StatelessWidget {

  const PreviewNoteCard({super.key});

  @override
  Widget build(BuildContext context){

    const cardPadding = 5.0;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.fromMap({WidgetState.any: Theme.of(context).colorScheme.primary}),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))
        )
      ),
      onPressed: () => {},
      child: Padding(
        padding: const EdgeInsets.all(cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText( // First, the title of the note in bold style and bigger
                text: TextSpan(
                  text: "Titre de la note",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 242, 242, 242))// fontSize: MediaQuery.of(context).size.width * 1.5 )
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10.0,),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText( // Then, a preview of the note with the first lines
                text: TextSpan(
                  text: "Aperçu du contenu de la note",
                  style: TextStyle(fontWeight: FontWeight.w300, color: Color.fromARGB(255, 159, 159, 162)) // fontSize: MediaQuery.of(context).size.width * 0.5)
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}