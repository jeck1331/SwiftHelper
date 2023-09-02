import 'package:flutter_new_app/api/plan_api.dart';
import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/models/api/plan_stage_entry.dart';
import 'package:flutter_new_app/models/enums/stage_priority.dart';
import 'package:flutter_new_app/models/enums/stage_status.dart';
import 'package:flutter_new_app/widgets/add_widgets/plan/stage_bloc/add_stage_bloc.dart';

import '../../../constants/constant_data_stages.dart';
import '../../../models/key_value_model.dart';
import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';

class AddStageWidget extends StatelessWidget {
  const AddStageWidget({super.key, this.planId});

  final num? planId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStageBloc()
        ..add(AddStageInitialEvent('', DateTime.now(), '', planId, const KeyValueModel(key: 0, value: 'Нет'),
            const KeyValueModel(key: 0, value: 'Не активен'))),
      child: const AddStageScreen(),
    );
  }
}

class AddStageScreen extends StatelessWidget {
  const AddStageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((AddStageBloc bloc) => bloc);

    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
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
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: TextField(
                        obscureText: false,
                        onChanged: (text) {
                          bloc.add(ChangeTitle(text));
                        },
                        decoration: TextFormFieldStyle.textFieldStyle(
                            labelTextStr: 'Наименование *', hintTextStr: 'Введите наименование')),
                  ))),
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
                        onChanged: (text) {
                          bloc.add(ChangeData(text));
                        },
                        decoration: TextFormFieldStyle.textFieldStyle(
                            labelTextStr: 'Описание ', hintTextStr: 'Введите описание')),
                  ))),
          const Flexible(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: _DateTimeField(),
                  ))),
          Flexible(
              child: FractionallySizedBox(
            widthFactor: 0.6,
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(ConstantColors.mainBgColor),
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))))),
                onPressed: () async {
                  var res = await PlanApi().addStage(PlanStageEntry(
                      title: bloc.state.title,
                      createdDate: bloc.state.createdDate ?? DateTime.now(),
                      id: 0,
                      data: bloc.state.data,
                      status: StageStatus.values[bloc.state.status!.key as int],
                      priority: StagePriority.values[bloc.state.priority!.key as int],
                      planEntryId: bloc.state.planId ?? 0));
                  ScaffoldMessenger.of(context).showSnackBar(res == 200
                      ? ScaffoldMessengers().info('Создан этап: ${bloc.state.title}')
                      : ScaffoldMessengers().error);
                },
                child: const Text('Добавить')),
          ))
        ],
      ),
    );
  }
}

class _PlanDropdownButton extends StatelessWidget {
  const _PlanDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(border: OutlineInputBorder(gapPadding: 0.0), labelText: "Родительский элемент (план)*");

    final plans = context.select((AddStageBloc bloc) => bloc.state.plans);
    final planId = context.select((AddStageBloc bloc) => bloc.state.planId);

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
            context.read<AddStageBloc>().add(ChangeParentPlan(value.key));
          }
        });
  }
}

class _PriorityDropdownButton extends StatelessWidget {
  const _PriorityDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(
      border: OutlineInputBorder(gapPadding: 0.0),
        labelText: "Приоритет");

    final priorities = ConstantDataStages.priorities;
    final priorityState = context.select((AddStageBloc bloc) => bloc.state.priority);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        items: priorities.map((KeyValueModel item) {
          return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
        }).toList(),
        value: priorities.firstWhere((element) => element.key == priorityState!.key),
        onChanged: (value) {
          if (value != null) {
            context.read<AddStageBloc>().add(ChangePriority(value));
          }
        });
  }
}

class _StatusDropdownButton extends StatelessWidget {
  const _StatusDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(
      border: OutlineInputBorder(gapPadding: 0.0),
      labelText: "Статус"
    );

    final statuses = ConstantDataStages.statuses;
    final statusState = context.select((AddStageBloc bloc) => bloc.state.status);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        items: statuses.map((KeyValueModel item) {
          return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
        }).toList(),
        value: statuses.firstWhere((element) => element.key == statusState!.key),
        onChanged: (value) {
          if (value != null) {
            context.read<AddStageBloc>().add(ChangeStatus(value));
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

    final date = context.select((AddStageBloc bloc) => bloc.state.createdDate);
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
          context.read<AddStageBloc>().add(ChangeDate(pickedDate ?? DateTime.now()));
          dateInput.text = pickedDate?.toNormalizedString ?? '';
        });
  }
}
