import 'package:flutter_new_app/api/plan_api.dart';
import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/models/api/plan_entry.dart';
import 'package:flutter_new_app/widgets/add_widgets/plan/plan_bloc/plan_bloc.dart';

import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';

class AddPlanWidget extends StatelessWidget {
  const AddPlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanBloc()..add(AddPlanInitialEvent('', DateTime.now(), '')),
      child: const AddPlanScreen(),
    );
  }
}

class AddPlanScreen extends StatelessWidget {
  const AddPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((PlanBloc bloc) => bloc);

    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
          Flexible(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: TextField(
                        obscureText: false,
                        onChanged: (text) {
                          bloc.add(ChangeDescription(text));
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
                      var res = await PlanApi().addPlan(PlanEntry(
                          title: bloc.state.title,
                          createdDate: bloc.state.createdDate ?? DateTime.now(),
                          id: 0,
                          description: bloc.state.description));
                      ScaffoldMessenger.of(context).showSnackBar(res == 200
                          ? ScaffoldMessengers().info('Создан план: ${bloc.state.title}')
                          : ScaffoldMessengers().error);
                    },
                    child: const Text('Добавить')),
              ))
        ],
      ),
    );
  }
}

class _DateTimeField extends StatelessWidget {
  const _DateTimeField();

  @override
  Widget build(BuildContext context) {
    var dateDropdown = const InputDecoration(icon: Icon(Icons.calendar_today), labelText: "Введите дату");
    TextEditingController dateInput = TextEditingController();

    final date = context.select((PlanBloc bloc) => bloc.state.createdDate);
    dateInput.text = date?.toLocal().toStringNamed ?? DateTime.now().toLocal().toStringNamed;

    return TextField(
        decoration: dateDropdown,
        controller: dateInput,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100)
          );
          context.read<PlanBloc>().add(ChangeDate(pickedDate ?? DateTime.now()));
          dateInput.text = pickedDate?.toNormalizedString ?? '';
        });
  }
}
