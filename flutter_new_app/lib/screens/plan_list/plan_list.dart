import 'package:flutter_new_app/models/api/plan_entry.dart';
import 'package:flutter_new_app/screens/plan_stages_list/plan_stages_list.dart';

import '../../modules/home_auth/cubit/home_auth_nav_cubit.dart';
import '../../widgets/messengers/scaffold_messengers.dart';
import '../../widgets/modals/remove_modal.dart';
import '../../widgets/plan/plan_list_item.dart';
import 'plan_list_imports.dart';

class PlanListScreen extends StatelessWidget {
  const PlanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PlanListBloc()..add(PlanListInitEvent()),
        child: BlocBuilder<PlanListBloc, PlanListInitial>(builder: (context, state) {
          final bloc = context.read<PlanListBloc>();
          return RefreshIndicator(
              onRefresh: () async => bloc.add(PlanListInitEvent()),
              child: Scaffold(
                  backgroundColor: ConstantColors.mainBgColor,
                  body: ListView.separated(
                    itemBuilder: (context, index) {
                      List<PlanEntry> noteItems = state.data;
                      PlanEntry data;
                      var isSelected = state.selectedId != null && state.selectedId == noteItems[index].id;

                      if (noteItems.isNotEmpty) {
                        data = noteItems[index];
                        return InkWell(
                          child: Container(
                            color: isSelected ? Colors.lightBlueAccent : null,
                            child: ListTile(
                              key: ValueKey(data.id),
                              onTap: () {
                                  context
                                      .read<HomeAuthNavCubit>()
                                      .changePageRoute(PlanStagesList(planId: data.id,), 'Планы', 4);
                              },
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => RemoveModalWidget(type: 0, entryId: data.id ?? -1))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info(value as String));
                                  if (value == 'Удачно') {
                                    bloc.add(PlanListInitEvent());
                                  }
                                });
                              },
                              selected: isSelected,
                              title: PlanListItem(plan: data),
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
                                        const AddModule(categoryType: CategoryType.plan, keyType: 0)));
                              },
                              child: const Text('Добавить')),
                        )
                      ],
                    ),
                  )));
        }));
  }
}