import 'dart:io';

import 'package:flutter_new_app/api/plan_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/models/api/plan_stage_entry.dart';
import 'package:flutter_new_app/models/enums/stage_priority.dart';
import 'package:flutter_new_app/models/enums/stage_status.dart';
import 'package:flutter_new_app/screens/plan_stage_detail/bloc/plan_stage_detail_bloc.dart';

import '../../../constants/constant_data_stages.dart';
import '../../../models/key_value_model.dart';
import '../../constants/constant_colors.dart';
import '../../models/styles/text_form_field_style.dart';
import '../../modules/home_auth/cubit/home_auth_nav_cubit.dart';
import '../../widgets/messengers/scaffold_messengers.dart';
import '../plan_stages_list/plan_stages_list.dart';

class PlanStageDetailWidget extends StatelessWidget {
  const PlanStageDetailWidget({super.key, required this.planId, required this.title, required this.id});

  final num planId;
  final num id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanStageDetailBloc()..add(PlanStageDetailInitialEvent(planId, id)),
      child: BlocBuilder<PlanStageDetailBloc, PlanStageDetailInitialState>(
        builder: (context, state) {
          final bloc = context.read<PlanStageDetailBloc>();

          TextEditingController titleController = TextEditingController(text: state.title);
          titleController.value = titleController.value.copyWith(
              text: bloc.state.title,
              selection: TextSelection.fromPosition(TextPosition(offset: bloc.state.title.length)));

          TextEditingController dataController = TextEditingController(text: state.data);
          dataController.value = dataController.value.copyWith(
              text: bloc.state.data,
              selection: TextSelection.fromPosition(TextPosition(offset: bloc.state.data.length)));

          return RefreshIndicator(
            onRefresh: () async => bloc.add(PlanStageDetailInitialEvent(planId, id)),
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: ConstantColors.mainMenuBtn,
                  title: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                          onPressed: () => context
                              .read<HomeAuthNavCubit>()
                              .changePageRoute(PlanStagesList(planId: planId), 'Планы', 4),
                          icon: const Icon(Icons.arrow_back_ios_rounded)),
                    ),
                    Text(title)
                  ]),
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          const Flexible(
                              child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: _PlanDropdownButton(),
                                  ))),
                          Flexible(
                              child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: TextFormField(
                                          controller: titleController,
                                          obscureText: false,
                                          keyboardType: TextInputType.multiline,
                                          onChanged: (text) {
                                            bloc.add(ChangeTitle(text));
                                          },
                                          decoration: TextFormFieldStyle.textFieldStyle(
                                              labelTextStr: 'Наименование *', hintTextStr: 'Введите наименование'))))),
                          const Flexible(
                              child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: _PriorityDropdownButton(),
                                  ))),
                          const Flexible(
                              child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: _StatusDropdownButton(),
                                  ))),
                          Flexible(
                              child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextField(
                                        obscureText: false,
                                        keyboardType: TextInputType.multiline,
                                        onChanged: (text) {
                                          //bloc.changeData(text);
                                          bloc.add(ChangeData(text));
                                        },
                                        controller: dataController,
                                        decoration: TextFormFieldStyle.textFieldStyle(
                                            labelTextStr: 'Описание *', hintTextStr: 'Введите описание')),
                                  ))),
                          const Flexible(
                              child: FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: _DateTimeField(),
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  color: ConstantColors.mainMenuBtn,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(ConstantColors.mainBgColor),
                                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))))),
                            onPressed: () async {
                              var res = await PlanApi().updateStage(PlanStageEntry(
                                  title: bloc.state.title,
                                  createdDate: bloc.state.createdDate ?? DateTime.now(),
                                  id: bloc.state.id,
                                  data: bloc.state.data,
                                  status: StageStatus.values[bloc.state.status!.key as int],
                                  priority: StagePriority.values[bloc.state.priority!.key as int],
                                  planEntryId: bloc.state.planId ?? 0));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(res == 200 ? ScaffoldMessengers().success : ScaffoldMessengers().error);
                            },
                            child: const Text('Сохранить изменения')),
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class _PlanDropdownButton extends StatelessWidget {
  const _PlanDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown =
        const InputDecoration(border: OutlineInputBorder(gapPadding: 0.0), labelText: "Родительский элемент (план)*");

    final plans = context.select((PlanStageDetailBloc bloc) => bloc.state.plans);
    final planId = context.select((PlanStageDetailBloc bloc) => bloc.state.planId);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        items: plans != null && plans.isNotEmpty
            ? plans.map((KeyValueModel item) {
                return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
              }).toList()
            : const [],
        value: plans != null && plans.isNotEmpty
            ? plans.firstWhere((element) => element.key == planId)
            : const KeyValueModel(key: 0, value: 'Пусто'),
        onChanged: (value) {
          if (value != null) {
            context.read<PlanStageDetailBloc>().add(ChangeParentPlan(value.key));
          }
        });
  }
}

class _PriorityDropdownButton extends StatelessWidget {
  const _PriorityDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(border: OutlineInputBorder(gapPadding: 0.0), labelText: "Приоритет");

    final priorities = ConstantDataStages.priorities;
    final priorityState = context.select((PlanStageDetailBloc bloc) => bloc.state.priority);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        items: priorities.map((KeyValueModel item) {
          return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
        }).toList(),
        value: priorities.firstWhere((element) => element.key == priorityState!.key),
        onChanged: (value) {
          if (value != null) {
            context.read<PlanStageDetailBloc>().add(ChangePriority(value));
          }
        });
  }
}

class _StatusDropdownButton extends StatelessWidget {
  const _StatusDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(border: OutlineInputBorder(gapPadding: 0.0), labelText: "Статус");

    final statuses = ConstantDataStages.statuses;
    final statusState = context.select((PlanStageDetailBloc bloc) => bloc.state.status);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        items: statuses.map((KeyValueModel item) {
          return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
        }).toList(),
        value: statuses.firstWhere((element) => element.key == statusState!.key),
        onChanged: (value) {
          if (value != null) {
            context.read<PlanStageDetailBloc>().add(ChangeStatus(value));
          }
        });
  }
}

class _DateTimeField extends StatelessWidget {
  const _DateTimeField();

  @override
  Widget build(BuildContext context) {
    var dateDropdown = const InputDecoration(icon: Icon(Icons.calendar_today), labelText: "Введите дату");
    TextEditingController dateInput = TextEditingController();

    final date = context.select((PlanStageDetailBloc bloc) => bloc.state.createdDate);
    dateInput.text = date?.toLocal().toStringNamed ?? DateTime.now().toLocal().toStringNamed;

    return TextField(
        decoration: dateDropdown,
        controller: dateInput,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100));
          context.read<PlanStageDetailBloc>().add(ChangeDate(pickedDate ?? DateTime.now()));
          dateInput.text = pickedDate?.toNormalizedString ?? '';
        });
  }
}
