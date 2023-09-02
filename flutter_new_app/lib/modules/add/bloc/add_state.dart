part of 'add_bloc.dart';

abstract class AddState extends Equatable {
  const AddState();

  @override
  List<Object> get props => [];
}

class AddInitialState extends AddState {
  const AddInitialState._({
      this.categories = const <KeyValueModel>[],
      this.operations = const <KeyValueModel>[],
      this.selectedOperation = const KeyValueModel(key: 0, value: ''),
      this.selectedCategory = const KeyValueModel(key: 0, value: ''),
      this.selectedCategoryId = CategoryType.finance,
      this.selectedOperationId = 0,
      this.showedTypeWidget = const AddAccountWidget(),
      this.isLoading = false
  });

  AddInitialState copyWith(
      {List<KeyValueModel>? categories,
      List<KeyValueModel>? operations,
      CategoryType? selectedCategoryId,
      KeyValueModel? selectedOperation,
      KeyValueModel? selectedCategory,
      num? selectedOperationId,
      Widget? showedTypeWidget,
      bool isLoading = false}) {
    return AddInitialState._(
        categories: categories ?? this.categories,
        operations: operations ?? this.operations,
        selectedOperation: selectedOperation ?? this.selectedOperation,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        selectedOperationId: selectedOperationId ?? this.selectedOperationId,
        showedTypeWidget: showedTypeWidget ?? this.showedTypeWidget,
        isLoading: isLoading);
  }

  final List<KeyValueModel> categories;
  final List<KeyValueModel> operations;
  final KeyValueModel selectedCategory;
  final KeyValueModel selectedOperation;
  final CategoryType selectedCategoryId;
  final num selectedOperationId;
  final Widget showedTypeWidget;
  final bool isLoading;

  @override
  List<Object> get props => [categories, operations, selectedCategory, selectedOperation, selectedCategoryId, selectedOperationId, showedTypeWidget, isLoading];
}
