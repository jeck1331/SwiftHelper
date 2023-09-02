import 'package:flutter_new_app/extensions/text_styles.dart';
import 'package:flutter_new_app/models/api/plan_stage_entry.dart';
import 'package:flutter_new_app/modules/plans/plans.dart';
import 'package:flutter_new_app/screens/plan_stages_list/bloc/plan_stages_list_bloc.dart';

import '../../models/key_value_model.dart';
import '../../modules/home_auth/cubit/home_auth_nav_cubit.dart';
import '../../widgets/messengers/scaffold_messengers.dart';
import '../../widgets/modals/remove_modal.dart';
import '../../widgets/plan/plan_stage_item.dart';
import '../plan_stage_detail/plan_stage_detail.dart';
import 'plan_stages_list_imports.dart';

class PlanStagesList extends StatelessWidget {
  const PlanStagesList({super.key, required this.planId});

  final num planId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PlanStagesListBloc()..add(PlanStagesListInitEvent(planId)),
        child: BlocBuilder<PlanStagesListBloc, PlanStagesInitialState>(builder: (context, state) {
          final bloc = context.read<PlanStagesListBloc>();
          return RefreshIndicator(
              onRefresh: () async => bloc.add(PlanStagesListInitEvent(planId)),
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: ConstantColors.mainBgColor,
                    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      IconButton(
                          onPressed: () =>
                              context.read<HomeAuthNavCubit>().changePageRoute(const PlansModule(), 'Планы', 4),
                          icon: const Icon(Icons.arrow_back_ios_rounded)),
                      const _SortDropdownButton()
                    ]),
                  ),
                  backgroundColor: ConstantColors.mainBgColor,
                  body: ListView.separated(
                    itemBuilder: (context, index) {
                      List<PlanStageEntry> stages = state.stages;
                      PlanStageEntry data;
                      var isSelected = state.selectedId != null && state.selectedId == stages[index].id;

                      if (stages.isNotEmpty) {
                        data = stages[index];
                        return InkWell(
                          child: Container(
                            color: isSelected ? Colors.lightBlueAccent : null,
                            child: ListTile(
                              key: ValueKey(data.id),
                              onTap: () {
                                context.read<HomeAuthNavCubit>().changePageRoute(PlanStageDetailWidget(planId: data.planEntryId, id: data.id, title: data.title), 'Планы', 4);
                              },
                              onLongPress: () {
                                showDialog(
                                        context: context,
                                        builder: (context) => RemoveModalWidget(type: 0, entryId: data.id ?? -1))
                                    .then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(ScaffoldMessengers().info(value as String));
                                  if (value == 'Удачно') {
                                    bloc.add(PlanStagesListInitEvent(planId));
                                  }
                                });
                              },
                              selected: isSelected,
                              title: PlanStageItem(stage: data),
                              minVerticalPadding: 0,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: Text('Нет данных'));
                      }
                    },
                    itemCount: state.stages.isNotEmpty ? state.stages.length : 1,
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
                                        builder: (context) => AddModule(
                                              categoryType: CategoryType.plan,
                                              keyType: 1,
                                              parentStageId: bloc.state.planId,
                                            )));
                              },
                              child: const Text('Добавить')),
                        )
                      ],
                    ),
                  )));
        }));
  }
}

class _SortDropdownButton extends StatelessWidget {
  const _SortDropdownButton();

  @override
  Widget build(BuildContext context) {
    final sorts = <KeyValueModel>[
      const KeyValueModel(key: 0, value: 'Дата'),
      const KeyValueModel(key: 1, value: 'Приоритет'),
      const KeyValueModel(key: 2, value: 'Статус'),
    ];
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    final filter = context.select((PlanStagesListBloc bloc) => bloc.state.filter);
    final sortByAsc = context.select((PlanStagesListBloc bloc) => bloc.state.sortByAsc);

    return Row(
      children: [
        Row(
          children: [
            Text('По возрастанию:', style: const TextStyle().lightWhite,),
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                checkColor: Colors.blueAccent,
                fillColor: MaterialStateColor.resolveWith(getColor),
                value: sortByAsc,
                onChanged: (bool? value) {
                  context.read<PlanStagesListBloc>().add(ChangeSort(value ?? false));
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Text('Фильтр:', style: const TextStyle().lightWhite),
            ),
            SizedBox(
              height: 40,
              width: 100,
              child: DropdownButton(
                  isExpanded: true,
                  dropdownColor: ConstantColors.mainBgColor,
                  items: sorts.map((KeyValueModel item) {
                    return DropdownMenuItem<KeyValueModel>(
                        value: item,
                        child: Text(
                          item.value,
                          style: const TextStyle().boldText,
                        ));
                  }).toList(),
                  value: sorts.firstWhere((element) => element.key == filter.key),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<PlanStagesListBloc>().add(ChangeFilter(value));
                    }
                  }),
            ),
          ],
        ),
      ],
    );
  }
}