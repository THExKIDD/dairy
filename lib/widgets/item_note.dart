import 'package:diary/widgets/add_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary/Repository/notes_repository.dart';
import 'package:diary/models/note.dart';
import 'package:intl/intl.dart';


class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AddNoteScreen(note: note)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purpleAccent,
                ),
                child: Column(
                  children: [
                    Text(
                        DateFormat(DateFormat.ABBR_MONTH).format(note.createdAt),
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                        DateFormat(DateFormat.DAY).format(note.createdAt),
                      style: TextStyle(
                        color: Colors.white,
                      ),

                    ),
                    SizedBox(height: 3),
                    Text(
                      note.createdAt.year.toString(),
                      style: TextStyle(
                        color: Colors.white70,
                      ),

                    ),

                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                              note.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(
                            DateFormat(DateFormat.HOUR_MINUTE).format(note.createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    Text(
                      note.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
