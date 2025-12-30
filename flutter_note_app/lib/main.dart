import 'package:flutter/material.dart';
import 'package:flutter_note_app/db.dart';
import 'package:flutter_note_app/note.class.dart';
import 'package:flutter_note_app/note_card.dart';
import 'package:flutter_note_app/preview_note_card.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Notes App',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 69, 222, 220)),
        ),
        home: const MyHomePage(title: 'Your notes'),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  int indexPage = -1;
  bool newNote = false;

  Note? n;

  void accessNote(int i){
    indexPage = i;
    n = Note(id: indexPage);
    notifyListeners();
  }

  void setNewNote(){
    newNote = !newNote;
    notifyListeners();
  }

  void modifyTitle(String title) {
    n?.setTitle(title);
  }

  void modifyContent(String content) {
    n?.setContent(content);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    int index = appState.indexPage;
    DB db = DB.instance;
    Widget page;

    if (appState.newNote){
      page = NewNoteCard();
    } else {
      if (index == -1){
        page = HomeContainer();
      } else {
        page = NoteCard(index: index);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: page
    );
  }
}

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    DB db = DB.instance;
    var appState = context.watch<MyAppState>();
    // int count = db.getNumber();
    // db.initializeDatabase();
    // db.insertNote(Note(id: 0, titre: 'Titre test', contenu: 'Contenu test'));
    // print(db.getNumber());
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
              onPressed: () async {
                print("Ajout d'une note");
                appState.setNewNote();
              },
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: SizedBox(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: FutureBuilder<List?>( // AFfichage des 
                  future: db.getNumber(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text("Loading...");
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List data = snapshot.data ?? [];
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return PreviewNoteCard(index: index, title: (data[index] as Map)['titre'], content: (data[index] as Map)['contenu']);
                            }
                          );
                        }
                    }
                  },
                ),
                // child: ListView.builder(
                //   itemCount: db.getNumber(),
                //   itemBuilder: (BuildContext context, int index){
                //     return PreviewNoteCard(index: index);
                //   },
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
