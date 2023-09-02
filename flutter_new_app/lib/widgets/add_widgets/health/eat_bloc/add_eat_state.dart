part of 'add_eat_bloc.dart';

abstract class AddEatState {
  const AddEatState();
}

class AddEatInitialState extends AddEatState {
  const AddEatInitialState._({
      this.title = '',
      this.createdDate,
      this.category = const KeyValueModel(key: 0, value: 'Пусто'),
      this.categories = const [KeyValueModel(key: 0, value: 'Пусто')]
  });

  AddEatInitialState copyWith(
      {String? title, DateTime? createdDate, KeyValueModel? category, List<KeyValueModel>? categories}) {
    return AddEatInitialState._(
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
        categories: categories ?? this.categories,
        category: category ?? this.category);
  }

  final String title;
  final DateTime? createdDate;
  final KeyValueModel category;
  final List<KeyValueModel> categories;
}
