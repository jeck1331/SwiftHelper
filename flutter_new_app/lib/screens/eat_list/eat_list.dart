import 'package:flutter_new_app/modules/health/health.dart';
import 'package:flutter_new_app/screens/eat_list/bloc/eat_list_bloc.dart';
import 'package:flutter_new_app/screens/note_detail/note_detail_imports.dart';
import 'package:flutter_new_app/widgets/health/health_eat_item.dart';

import '../../models/api/health_eat.dart';
import '../../modules/home_auth/cubit/home_auth_nav_cubit.dart';
import '../../widgets/messengers/scaffold_messengers.dart';
import '../../widgets/modals/remove_modal.dart';

class EatListScreen extends StatelessWidget {
  const EatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EatListBloc>(
      create: (context) => EatListBloc()..add(EatInitEvent()),
      child: const EatListScreenWidget()
    );
  }
}

class EatListScreenWidget extends StatelessWidget {
  const EatListScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EatListBloc, EatInitialState>(builder: (context, state) {
        final bloc = context.read<EatListBloc>();
        return RefreshIndicator(
          onRefresh: () async => bloc.add(EatInitEvent()),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: ConstantColors.mainBgColor,
              title: IconButton(onPressed: () =>
                  context.read<HomeAuthNavCubit>().changePageRoute(const HealthModule(), 'Здоровье', 2),
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
            ),
            body: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        List<Eat> financeItems = state.eatItems;
                        Eat data;
                        var isSelected = state.selectedId != null && state.selectedId == financeItems[index].id;

                        if (financeItems.isNotEmpty) {
                          data = financeItems[index];
                          return InkWell(
                            child: Container(
                              color: isSelected ? Colors.lightBlueAccent : null,
                              child: ListTile(
                                key: ValueKey(data.id),
                                onTap: () {},
                                onLongPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => RemoveModalWidget(type: 2, entryId: data.id))
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info(value as String));
                                    if (value == 'Удачно') {
                                      bloc.add(EatInitEvent());
                                    }
                                  });
                                },
                                selected: isSelected,
                                title: HealthEatItemWidget(eat: data),
                                minVerticalPadding: 0,
                                contentPadding: const EdgeInsets.all(0),
                              ),
                            ),
                          );
                        } else {
                          return const Center(child: Text('Нет данных'));
                        }
                      },
                      childCount: state.eatItems.isNotEmpty ? state.eatItems.length : 1,
                    ))
              ],
            ),
            bottomNavigationBar: Container(
              color: ConstantColors.mainBgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const AddModule(categoryType: CategoryType.health, keyType: 0)));
                          },
                          child: const Text('Добавить')),
                    ),
                  ),
                ],
              ),
            )
          ),
        );
      },
    );
  }
}