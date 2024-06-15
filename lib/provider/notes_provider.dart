import 'package:flutter/material.dart';
import 'package:diary/models/note.dart';
import 'package:diary/Repository/notes_repository.dart';
import 'package:provider/provider.dart';

class NotesProvider with ChangeNotifier {
  List<Note>? notes;

  NotesProvider()
  {
    getNotes();
  }

  getNotes() async {
    notes = await NotesRepository.getNotes()?? [];
    notifyListeners();
  }

  insert({required Note note}) async
  {
    notes=  await NotesRepository.insert(note: note);
     getNotes();
  }

  update({required Note note}) async
  {
    notes=  await NotesRepository.update(note: note);
    getNotes();
  }
  Future<bool> delete({required Note note}) async
  {
    notes = await NotesRepository.delete(note: note);
     getNotes();
     return true;


  }



}