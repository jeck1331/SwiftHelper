import 'package:flutter_new_app/api/health_api.dart';
import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/models/api/health_eat.dart';
import 'package:flutter_new_app/widgets/add_widgets/health/eat_bloc/add_eat_bloc.dart';

import '../../../models/key_value_model.dart';
import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';

class AddEatWidget extends StatelessWidget {
  const AddEatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEatBloc()..add(AddEatInitialEvent('', DateTime.now(), null, [])),
      child: const AddEatScreen(),
    );
  }
}

class AddEatScreen extends StatelessWidget {
  const AddEatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((AddEatBloc bloc) => bloc);

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
          const Flexible(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: _CategoryDropdownButton(),
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
                  var res = await HealthApi().createEat(Eat(
                      title: bloc.state.title,
                      createdDate: bloc.state.createdDate ?? DateTime.now(),
                      categoryId: bloc.state.category.key,
                      categoryName: bloc.state.category.value,
                      id: 0));
                  ScaffoldMessenger.of(context).showSnackBar(res == 200
                      ? ScaffoldMessengers().info('Создана запись питания: ${bloc.state.title}')
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

    final date = context.select((AddEatBloc bloc) => bloc.state.createdDate);
    dateInput.text = date?.toStringNamed ?? DateTime.now().toStringNamed;

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
          context.read<AddEatBloc>().add(ChangeDate(pickedDate ?? DateTime.now()));
          dateInput.text = pickedDate?.toNormalizedString ?? '';
        });
  }
}

class _CategoryDropdownButton extends StatelessWidget {
  const _CategoryDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(
      border: OutlineInputBorder(gapPadding: 0.0),
    );

    final categories = context.select((AddEatBloc bloc) => bloc.state.categories);
    final category = context.select((AddEatBloc bloc) => bloc.state.category);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        items: categories.isNotEmpty
            ? categories.map((KeyValueModel item) {
                return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
              }).toList()
            : const [],
        value: categories.isNotEmpty ? category : const KeyValueModel(key: 0, value: 'Пусто'),
        onChanged: (value) {
          if (value != null) {
            context.read<AddEatBloc>().add(ChangeCategory(value));
          }
        });
  }
}
