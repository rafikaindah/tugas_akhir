import 'package:flutter/material.dart';
import 'package:flutter_application_1/note.dart';
import 'package:flutter_application_1/note_database.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  //notes db
  final notesDatabase = NoteDatabase();

  //text controller
  final noteControllerr = TextEditingController();

  // user wants to add new note
  void addNewNote() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("New Note"),
            content: TextField(controller: noteControllerr),
            actions: [
              // cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  noteControllerr.clear();
                },
                child: const Text("Cancel"),
              ),

              // save button
              TextButton(
                onPressed: () {
                  //create a new note
                  final now = DateTime.now();
                  final newNote = Note(
                    content: noteControllerr.text,
                    createdAt: now,
                    updatedAt: now,
                  );
                  // save in db
                  notesDatabase.createNote(newNote);

                  Navigator.pop(context);
                  noteControllerr.clear();
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  // user wants to update note
  void updateNote(Note note) {
    // pre-fill text controller with existing note
    noteControllerr.text = note.content;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Update Note"),
            content: TextField(controller: noteControllerr),
            actions: [
              // cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  noteControllerr.clear();
                },
                child: const Text("Cancel"),
              ),

              // save button
              TextButton(
                onPressed: () {
                  // save in db
                  notesDatabase.updateNote(note, noteControllerr.text);

                  Navigator.pop(context);
                  noteControllerr.clear();
                },
                child: const Text("Save"),
              ),
            ],
          ),
    );
  }

  // user wants to delete note
  void deleteNote(Note note) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Delete Note?"),
            actions: [
              // cancel button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  noteControllerr.clear();
                },
                child: const Text("Cancel"),
              ),

              // save button
              TextButton(
                onPressed: () {
                  // save in db
                  notesDatabase.deleteNote(note);

                  Navigator.pop(context);
                  noteControllerr.clear();
                },
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }
  //BUILD UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(title: const Text("Notes")),
      // Button
      floatingActionButton: FloatingActionButton(
        onPressed: addNewNote,
        child: const Icon(Icons.add),
      ),

      // Body -> Stream Builder
      body: StreamBuilder(
        // Listens to this stream..
        stream: notesDatabase.stream,

        // to build our UI..
        builder: (context, snapshot) {
          //loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          //loaded!
          final notes = snapshot.data!();

          // list of notes UI
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.content),
                subtitle: Text(
                  'Dibuat: ${note.createdAt.toLocal().toString().substring(0, 16)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      //update button
                      IconButton(
                        onPressed: () => updateNote(note),
                        icon: const Icon(Icons.edit),
                      ),
                      //delete button
                      IconButton(
                        onPressed: () => deleteNote(note),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
