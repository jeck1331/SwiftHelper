import 'package:flutter_new_app/api/note_api.dart';
import 'package:flutter_new_app/modules/home_auth/home_auth_imports.dart';

import '../../widgets/messengers/scaffold_messengers.dart';
import 'note_detail_imports.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({super.key, required this.parentId, required this.title});

  final String title;
  final num parentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteDetailBloc()..add(NoteDetailInitEvent(noteEntryId: parentId)),
      child: BlocBuilder<NoteDetailBloc, NoteDetailInitial>(builder: (context, state) {
        final bloc = context.select((NoteDetailBloc bloc) => bloc);
        String lastData = '';
        TextEditingController controller = TextEditingController();
        controller.text = bloc.state.data ?? '';
        return Scaffold(
          backgroundColor: ConstantColors.mainBgColor,
          appBar: AppBar(
              backgroundColor: ConstantColors.mainBgColor,
              title: Row(
                children: [
                  IconButton(
                      onPressed: () =>
                          context.read<HomeAuthNavCubit>().changePageRoute(const NotesModule(), 'Заметки', 3),
                      icon: const Icon(Icons.arrow_back_ios_rounded)),
                  Text(title),
                ],
              )),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FractionallySizedBox(
                  heightFactor: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: StreamBuilder(
                          stream: bloc.dataStream,
                          initialData: bloc.state.data,
                          builder: (context, snapshot) {
                            lastData = snapshot.data ?? '';
                            return TextField(
                                controller: controller,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration.collapsed(hintText: "Введите текст..."),
                                maxLines: null,
                                scrollPadding: const EdgeInsets.all(20.0),
                                onChanged: (text) {
                                  lastData = text;
                                });
                          }),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    var response = await NoteApi().detailNote(NoteDetail(
                        id: state.id,
                        data: lastData,
                        type: state.type,
                        noteEntryId: state.noteEntryId,
                        createdDate: state.createdDate));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(response == 200 ? ScaffoldMessengers().success : ScaffoldMessengers().error);
                  },
                  child: const Text('Сохранить'))
            ],
          )
        );
      }),
    );
  }
}
