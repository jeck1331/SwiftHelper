import 'package:flutter/material.dart';
import 'package:flutter_new_app/screens/note_list/note_list.dart';

import '../../constants/constant_colors.dart';

class NotesModule extends StatelessWidget {
  const NotesModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantColors.mainBgColor,
      width: double.infinity,
      child: const NoteListScreen(),
    );
  }
}