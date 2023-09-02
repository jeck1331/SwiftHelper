part of 'add_eat_bloc.dart';

abstract class AddEatEvent {}

class AddEatInitialEvent extends AddEatEvent {
  AddEatInitialEvent(this.title, this.createdDate, this.category, this.categories);

  final String? title;
  final DateTime? createdDate;
  final KeyValueModel? category;
  final List<KeyValueModel> categories;
}

class ChangeTitle extends AddEatEvent {
  ChangeTitle(this.title);

  final String? title;
}

class ChangeDate extends AddEatEvent {
  ChangeDate(this.createdDate);

  final DateTime? createdDate;
}

class ChangeCategory extends AddEatEvent {
  ChangeCategory(this.category);

  final KeyValueModel? category;
}


class AddEat extends AddEatEvent {
  AddEat(this.title, this.createdDate, this.category);

  final String title;
  final DateTime? createdDate;
  final KeyValueModel category;
}
