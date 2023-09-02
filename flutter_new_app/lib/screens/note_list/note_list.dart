import 'package:flutter_new_app/models/enums/note_type.dart';
import 'package:flutter_new_app/widgets/note/note_list_item.dart';

import '../../models/api/note_item.dart';
import '../../modules/home_auth/cubit/home_auth_nav_cubit.dart';
import '../../widgets/messengers/scaffold_messengers.dart';
import '../../widgets/modals/remove_modal.dart';
import '../note_detail/note_detail.dart';
import 'note_list_imports.dart';

class NoteListScreen extends StatelessWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NoteListBloc()..add(NoteListInitEvent()),
        child: BlocBuilder<NoteListBloc, NoteListState>(builder: (context, state) {
          final bloc = context.read<NoteListBloc>();
          return RefreshIndicator(
              onRefresh: () async => bloc.add(NoteListInitEvent()),
              child: Scaffold(
                  backgroundColor: ConstantColors.mainBgColor,
                  body: ListView.separated(
                    itemBuilder: (context, index) {
                      List<NoteItem> noteItems = state.data;
                      NoteItem data;
                      var isSelected = state.selectedId != null && state.selectedId == noteItems[index].id;

                      if (noteItems.isNotEmpty) {
                        data = noteItems[index];
                        return InkWell(
                          child: Container(
                            color: isSelected ? Colors.lightBlueAccent : null,
                            child: ListTile(
                              key: ValueKey(data.id),
                              onTap: () {
                                if (data.type == NoteType.note) {
                                  context
                                      .read<HomeAuthNavCubit>()
                                      .changePageRoute(NoteDetailScreen(parentId: data.id,title: data.title), 'Заметка', 3);
                                } else {
                                  context
                                      .read<HomeAuthNavCubit>()
                                      .changePageRoute(NoteDetailScreen(parentId: data.id,title: data.title), 'Список', 3);
                                }
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => RemoveModalWidget(type: 0, entryId: data.id ?? -1))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info(value as String));
                                  if (value == 'Удачно') {
                                    bloc.add(NoteListInitEvent());
                                  }
                                });
                              },
                              selected: isSelected,
                              title: NoteListItemWidget(item: data),
                              minVerticalPadding: 0,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: Text('Нет данных'));
                      }
                    },
                    itemCount: state.data.isNotEmpty ? state.data.length : 1,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                        color: Colors.white,
                      );
                    },
                  ),
                  bottomNavigationBar: Container(
                    color: ConstantColors.mainMenuBtn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const AddModule(categoryType: CategoryType.note, keyType: 0)));
                              },
                              child: const Text('Добавить')),
                        )
                      ],
                    ),
                  )));
        }));
  }
}