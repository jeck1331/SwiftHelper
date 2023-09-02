part of 'add_sport_bloc.dart';

abstract class AddSportState {
  const AddSportState();
}

class AddSportInitialState extends AddSportState {
  const AddSportInitialState._({
      this.title = '',
      this.createdDate,
      this.category = const KeyValueModel(key: 0, value: 'Пусто'),
      this.categories = const [KeyValueModel(key: 0, value: 'Пусто')]
  });

  AddSportInitialState copyWith(
      {String? title, DateTime? createdDate, KeyValueModel? category, List<KeyValueModel>? categories}) {
    return AddSportInitialState._(
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
