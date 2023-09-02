import 'package:flutter/services.dart';
import 'package:flutter_new_app/models/enums/finance_type.dart';
import 'package:flutter_new_app/widgets/add_widgets/finances/finance_history_bloc/finance_history_bloc.dart';

import '../../../api/finance_api.dart';
import '../../../models/api/finance_history.dart';
import '../../../models/key_value_model.dart';
import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';

class AddHistoryWidget extends StatelessWidget {
  const AddHistoryWidget({super.key, required this.type});

  final FinanceHistoryType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinanceHistoryBloc()..add(FinanceHistoryInitialEvent('', 0, [], null, null, [], type)),
      child: const AddHistoryScreen(),
    );
  }
}

class AddHistoryScreen extends StatelessWidget {
  const AddHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.select((FinanceHistoryBloc bloc) => bloc);

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
                          bloc.add(ChangeProductName(text));
                        },
                        decoration: TextFormFieldStyle.textFieldStyle(
                            labelTextStr: 'Наименование *', hintTextStr: 'Введите наименование')),
                  ))),
          Flexible(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextField(
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        onChanged: (text) {
                          bloc.add(ChangeProductValue(int.parse(text)));
                        },
                        decoration:
                            TextFormFieldStyle.textFieldStyle(labelTextStr: 'Сумма', hintTextStr: 'Введите сумму')),
                  ))),
          const Flexible(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: _FinanceTypeCheckboxWidget(),
                  ))),
          const Flexible(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: _ShopCategoryDropdownButton(),
                  ))),
          const Flexible(
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: _FinanceAccountsDropdownButton(),
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
                  var res = await FinanceApi().createHistory(FinanceHistory(
                      itemValue: bloc.state.itemValue,
                      type: bloc.state.type,
                      itemName: bloc.state.itemName,
                      categoryShopId: bloc.state.shopCategory.key,
                      accountId: bloc.state.financeAccount.key));

                  if (res == 409) {
                    ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().errorMessage(
                        'Расход:${bloc.state.itemName}, не может быть добавлен, так как на счете недостаточно средств!'));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(res != null
                        ? ScaffoldMessengers().info(
                            '${bloc.state.type == FinanceHistoryType.expense ? 'Добавлено пополнение ' : 'Добавлен расход '}: ${bloc.state.itemName}')
                        : ScaffoldMessengers().error);
                  }
                },
                child: const Text('Добавить')),
          ))
        ],
      ),
    );
  }
}

class _ShopCategoryDropdownButton extends StatelessWidget {
  const _ShopCategoryDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(border: OutlineInputBorder(gapPadding: 0.0), labelText: 'Категория');

    final categories = context.select((FinanceHistoryBloc bloc) => bloc.state.shopCategories);
    final category = context.select((FinanceHistoryBloc bloc) => bloc.state.shopCategory);

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
            context.read<FinanceHistoryBloc>().add(ChangeShopCategory(value));
          }
        });
  }
}

class _FinanceTypeCheckboxWidget extends StatelessWidget {
  const _FinanceTypeCheckboxWidget();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.greenAccent;
    }
    return ConstantColors.mainBgColor;
  }

  @override
  Widget build(BuildContext context) {
    final type = context.select((FinanceHistoryBloc bloc) => bloc.state.type);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type == FinanceHistoryType.expense ? 'Пополнение' : 'Расход'),
          SizedBox(
            width: 30,
            height: 30,
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateColor.resolveWith(getColor),
              value: type == FinanceHistoryType.expense,
              onChanged: (bool? value) {
                context.read<FinanceHistoryBloc>().add(ChangeType((value ?? false) ? FinanceHistoryType.expense : FinanceHistoryType.replenishment));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _FinanceAccountsDropdownButton extends StatelessWidget {
  const _FinanceAccountsDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(border: OutlineInputBorder(gapPadding: 0.0), labelText: 'Счёт');

    final accounts = context.select((FinanceHistoryBloc bloc) => bloc.state.financeAccounts);
    final account = context.select((FinanceHistoryBloc bloc) => bloc.state.financeAccount);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        items: accounts.isNotEmpty
            ? accounts.map((KeyValueModel item) {
                return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
              }).toList()
            : const [],
        value: account,
        onChanged: (value) {
          if (value != null) {
            context.read<FinanceHistoryBloc>().add(ChangeFinanceAccount(value));
          }
        });
  }
}
