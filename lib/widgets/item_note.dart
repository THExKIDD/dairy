import 'package:diary/widgets/add_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:diary/models/note.dart';
import 'package:intl/intl.dart';


class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AddNoteScreen(note: note)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurpleAccent,
                ),
                child: Column(
                  children: [
                    Text(
                        DateFormat(DateFormat.ABBR_MONTH).format(note.createdAt),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                        DateFormat(DateFormat.DAY).format(note.createdAt),
                      style: const TextStyle(
                        color: Colors.white,
                          fontSize: 20,
                      ),

                    ),
                    const SizedBox(height: 3),
                    Text(
                      note.createdAt.year.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                          fontSize: 20,
                      ),

                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
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
                      style: const TextStyle(
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
