import 'package:flutter_new_app/models/api/health_life_activity.dart';
import 'package:flutter_new_app/modules/health/health.dart';
import 'package:flutter_new_app/screens/note_detail/note_detail_imports.dart';
import 'package:flutter_new_app/screens/sport_list/bloc/sport_list_bloc.dart';
import 'package:flutter_new_app/widgets/health/health_sport_item.dart';

import '../../modules/home_auth/cubit/home_auth_nav_cubit.dart';
import '../../widgets/messengers/scaffold_messengers.dart';
import '../../widgets/modals/remove_modal.dart';

class SportListScreen extends StatelessWidget {
  const SportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SportListBloc>(
        create: (context) => SportListBloc()..add(SportInitEvent()),
        child: const SportListScreenWidget()
    );
  }
}

class SportListScreenWidget extends StatelessWidget {
  const SportListScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportListBloc, SportInitialState>(builder: (context, state) {
      final bloc = context.read<SportListBloc>();
      return RefreshIndicator(
        onRefresh: () async => bloc.add(SportInitEvent()),
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
                      List<LifeActivity> sportItems = state.sportItems;
                      LifeActivity data;
                      var isSelected = state.selectedId != null && state.selectedId == sportItems[index].id;

                      if (sportItems.isNotEmpty) {
                        data = sportItems[index];
                        return InkWell(
                          child: Container(
                            color: isSelected ? Colors.lightBlueAccent : null,
                            child: ListTile(
                              key: ValueKey(data.id),
                              onTap: () {},
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => RemoveModalWidget(type: 3, entryId: data.id))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info(value as String));
                                  if (value == 'Удачно') {
                                    bloc.add(SportInitEvent());
                                  }
                                }).catchError((err) {
                                  ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().error);
                                });
                              },
                              selected: isSelected,
                              title: HealthSportItemWidget(sport: data),
                              minVerticalPadding: 0,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: Text('Нет данных'));
                      }
                    },
                    childCount: state.sportItems.isNotEmpty ? state.sportItems.length : 1,
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
                                    const AddModule(categoryType: CategoryType.health, keyType: 1)));
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