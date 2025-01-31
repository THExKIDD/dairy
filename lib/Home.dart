
import 'package:diary/provider/notes_provider.dart';
import 'package:diary/widgets/add_note_screen.dart';
import 'package:diary/widgets/item_note.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
            'My Diary',
          style: TextStyle(
            color: Colors.white
          ),

        ),
        centerTitle: true,
      ),

        body: Consumer<NotesProvider>(
          builder: (context, provider, child) {
            return provider.notes?.isEmpty?? true? const Center(child: Text('Empty')):
            ListView(
              children: provider.notes?.map((e) => Container(child: ItemNote(note: e))).toList()?? [],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNoteScreen()));
        },
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          child: const Icon(Icons.add),
        )
    );
  }
}
