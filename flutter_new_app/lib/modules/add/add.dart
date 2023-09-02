import 'package:flutter_new_app/models/enums/finance_type.dart';

import 'add_imports.dart';

class AddModule extends StatelessWidget {
  final num keyType;
  final CategoryType categoryType;
  final num? parentStageId;

  const AddModule({super.key, required this.keyType, required this.categoryType, this.parentStageId});

  @override
  Widget build(BuildContext context) {
    List<KeyValueModel> operations;
    KeyValueModel category =
        ConstantDataDropdowns.categories.firstWhere((element) => element.key == categoryType.index);
    switch (categoryType) {
      case CategoryType.finance:
        operations = ConstantDataDropdowns.finance;
        break;
      case CategoryType.health:
        operations = ConstantDataDropdowns.health;
        break;
      case CategoryType.plan:
        operations = ConstantDataDropdowns.plan;
        break;
      case CategoryType.note:
        operations = ConstantDataDropdowns.entry;
        break;
      default:
        operations = ConstantDataDropdowns.finance;
        break;
    }
    KeyValueModel addType = operations.firstWhere((element) => element.key == keyType);

    return BlocProvider(
        create: (_) => AddBloc()
          ..add(InitAddEvent(ConstantDataDropdowns.categories, operations, category, addType, parentStageId)),
        child: const AddForm());
  }
}

class AddForm extends StatelessWidget {
  const AddForm({super.key});

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingValueDropdown = const EdgeInsets.only(top: 15, left: 40);

    final showedWidget = context.select((AddBloc bloc) => bloc.state.showedTypeWidget);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ConstantColors.mainBgColor,
        title: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
            const Text('Создание записи',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
            IconButton(onPressed: () => print('s'), icon: const Icon(Icons.person)),
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.9,
                  child: Padding(
                    padding: paddingValueDropdown,
                    child: const _CategoryDropdownButton(),
                  ),
                ),
              ),
              Flexible(
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.9,
                  child: Padding(
                    padding: paddingValueDropdown,
                    child: const _OperationsDropdownButton(),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40),
                  child: showedWidget,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryDropdownButton extends StatelessWidget {
  const _CategoryDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(border: OutlineInputBorder(gapPadding: 0), labelText: "Категория");

    final categories = context.select((AddBloc bloc) => bloc.state.categories);
    final category = context.select((AddBloc bloc) => bloc.state.selectedCategory);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        isDense: true,
        items: categories.isNotEmpty
            ? categories.map((KeyValueModel item) {
                return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
              }).toList()
            : const [],
        value: category,
        onChanged: (value) {
          if (value != null) {
            context.read<AddBloc>().add(ChangeCategoryEvent(value));
          }
        });
  }
}

class _OperationsDropdownButton extends StatelessWidget {
  const _OperationsDropdownButton();

  @override
  Widget build(BuildContext context) {
    var decorationDropdown = const InputDecoration(border: OutlineInputBorder(gapPadding: 0.0), labelText: "Операции");
    final operations = context.select((AddBloc bloc) => bloc.state.operations);
    final category = context.select((AddBloc bloc) => bloc.state.selectedCategory);
    final operation = context.select((AddBloc bloc) => bloc.state.selectedOperation);

    return DropdownButtonFormField<KeyValueModel>(
        decoration: decorationDropdown,
        isExpanded: true,
        isDense: true,
        items: operations.isNotEmpty
            ? operations.map((KeyValueModel item) {
                return DropdownMenuItem<KeyValueModel>(value: item, child: Text(item.value));
              }).toList()
            : const [],
        value: operation,
        onChanged: (value) {
          if (value != null) {
            FinanceHistoryType? type = null;
            if (category.key == 0) {
              type = operation.key == 1 ? FinanceHistoryType.replenishment : operation.key == 2 ? FinanceHistoryType.expense : null;
            }
            context.read<AddBloc>().add(ChangeOperationEvent(value, type));
          }
        });
  }
}
