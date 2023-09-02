part of 'add_bloc.dart';

abstract class AddEvent extends Equatable {}

class InitAddEvent extends AddEvent {
  final List<KeyValueModel> categories;
  final List<KeyValueModel> operations;
  final KeyValueModel category;
  final KeyValueModel add;
  final num? planId;

  InitAddEvent(this.categories, this.operations, this.category, this.add, this.planId);

  @override
  List<Object?> get props => [categories, operations, add, category, planId];
}

class ChangeCategoryEvent extends AddEvent {
  final KeyValueModel selectedCategory;

  ChangeCategoryEvent(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

class ChangeOperationEvent extends AddEvent {
  final KeyValueModel selectedType;
  final FinanceHistoryType? type;

  ChangeOperationEvent(this.selectedType, this.type);

  @override
  List<Object?> get props => [selectedType, type ?? FinanceHistoryType.expense];
}

class LoadCategoriesEvent extends AddEvent {
  final List<KeyValueModel> categories;

  LoadCategoriesEvent(this.categories);

  @override
  List<Object?> get props => [categories];
}

class LoadOperationsEvent extends AddEvent {
  final List<KeyValueModel> operations;

  LoadOperationsEvent(this.operations);

  @override
  List<Object?> get props => [operations];
}
