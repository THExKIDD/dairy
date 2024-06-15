import 'package:diary/models/note.dart';
import 'package:diary/provider/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key, this.note});
  final Note? note;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
   void initState() {
     super.initState();
    if(widget.note != null)
      {
        _title.text = widget.note!.title;
        _description.text = widget.note!.description;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Note',
        ),
        actions: [
          IconButton(onPressed: () => widget.note == null ?
                _insertNote() : _updateNote(),
              icon: const Icon(Icons.done)
          ),
          widget.note!= null ?
          IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  content: const Text('Are u sure u want to delete this node?'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        child: const Text('No'),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      _deleteNote();
                    },
                      child: const Text('Yes'),
                    )
                  ],
                ));
              },
              icon: const Icon(Icons.delete))
              : const SizedBox(),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Expanded(
                child: TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
        
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Expanded(
                child: TextFormField(
                  controller: _description,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                  maxLines: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _insertNote() async {
    final note = Note(title: _title.text,
        description: _description.text,
        createdAt: DateTime.now(),
    );
    await Provider.of<NotesProvider>(context, listen: false).insert(note: note);
    Navigator.pop(context);
  }

  _updateNote() async {
    final note = Note(
      id: widget.note!.id!,
      title: _title.text,
        description: _description.text,
        createdAt: widget.note!.createdAt,
    );
    await Provider.of<NotesProvider>(context, listen: false).update(note: note);
    Navigator.pop(context);
  }

_deleteNote() async {
  await Provider.of<NotesProvider>(context, listen: false).delete(note: widget.note!).then((idDone){});
  Navigator.pop(context);
}
}
