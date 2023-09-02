import 'package:flutter/material.dart';
import 'package:flutter_new_app/models/enums/note_type.dart';

import '../../models/api/note_item.dart';

class NoteListItemWidget extends StatelessWidget {
  final NoteItem item;

  const NoteListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(item.title), Text(item.type == NoteType.list ? 'Список' : "Заметка")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(item.description), Text(formattingDate(item.createdDate ?? DateTime.now()))],
            ),
          )
        ],
      ),
    );
  }
  String formattingDate(DateTime date) => '${date.day.toString()}.${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}.${date.year.toString()}';
}
