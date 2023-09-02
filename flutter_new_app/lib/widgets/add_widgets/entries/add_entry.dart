import 'package:flutter_new_app/api/note_api.dart';
import 'package:flutter_new_app/models/api/note_item.dart';
import 'package:flutter_new_app/models/enums/note_type.dart';
import 'package:flutter_new_app/widgets/add_widgets/entries/bloc/entries_bloc.dart';

import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';

class AddEntryWidget extends StatelessWidget {
  const AddEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEntriesBloc(),
      child: BlocBuilder<AddEntriesBloc, AddNoteState>(builder: (context, state) {
        final bloc = context.read<AddEntriesBloc>();
        return IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: bloc.titleStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20, top: 20),
                              child: TextField(
                                  obscureText: false,
                                  onChanged: (text) {
                                    bloc.changeTitle(text);
                                    bloc.add(AddEvent(title: text));
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(
                                      labelTextStr: 'Наименование записи *',
                                      hintTextStr: 'Введите наименование записи')),
                            )));
                  }),
              StreamBuilder(
                  stream: bloc.descriptionStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextField(
                                  obscureText: false,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (text) {
                                    bloc.changeDescription(text);
                                    bloc.add(AddEvent(description: text));
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(
                                      labelTextStr: 'Описание', hintTextStr: 'Введите описание')),
                            )));
                  }),
              StreamBuilder(
                  stream: bloc.typeStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Тип записи: ${snapshot.data == NoteType.list ? 'Список' : 'Заметка'}"),
                                  Switch(
                                    value: snapshot.data == NoteType.list,
                                    onChanged: (value) {
                                      bloc.changeType(value ? NoteType.list : NoteType.note);
                                      bloc.add(AddEvent(type: value ? NoteType.list : NoteType.note));
                                    },
                                  ),
                                ],
                              ),
                            )));
                  }),
              Flexible(
                  child: FractionallySizedBox(
                widthFactor: 0.6,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(ConstantColors.mainBgColor),
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))))),
                    onPressed: () async {
                      await NoteApi()
                          .addNote(NoteItem(
                              id: bloc.state.id,
                              title: bloc.state.title,
                              description: bloc.state.description,
                              type: bloc.state.type,
                              refUserId: bloc.state.refUserId,
                              refNoteId: bloc.state.refNoteId,
                              noteDetailId: bloc.state.noteDetailId,
                              createdDate: bloc.state.createdDate))
                          .then((value) {
                        if (value == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info('Успешно создана заметка: ${bloc.state.title}"'));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().error);
                        }
                      });
                    },
                    child: const Text('Добавить')),
              ))
            ],
          ),
        );
      }),
    );
  }
}
