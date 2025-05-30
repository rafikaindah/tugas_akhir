import 'package:flutter_application_1/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteDatabase {
  //Database -> notes
  final database = Supabase.instance.client.from('notes');

  //Create
  Future createNote(Note newNote) async {
    final now = DateTime.now();
    final noteWithDate = Note(
      id: newNote.id,
      content: newNote.content,
      createdAt: now,
      updatedAt: now,
    );
    await database.insert(noteWithDate.toMap());
  }

  //Read
  final stream = Supabase.instance.client
      .from('notes')
      .stream(primaryKey: ['id'])
      .map((data) => data.map((noteMap) => Note.fromMap(noteMap)).toList);

  //Update
  Future updateNote(Note oldNote, String newContent) async {
    final now = DateTime.now();
    await database
        .update({'content': newContent, 'updated_at': now.toIso8601String()})
        .eq('id', oldNote.id!);
  }

  //Delete
  Future deleteNote(Note note) async {
    await database.delete().eq('id', note.id!);
  }
}
