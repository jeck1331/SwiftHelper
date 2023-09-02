part of 'add_sport_bloc.dart';

abstract class AddSportEvent {}

class AddSportInitialEvent extends AddSportEvent {
  AddSportInitialEvent(this.title, this.createdDate, this.category, this.categories);

  final String? title;
  final DateTime? createdDate;
  final KeyValueModel? category;
  final List<KeyValueModel> categories;
}

class ChangeTitle extends AddSportEvent {
  ChangeTitle(this.title);

  final String? title;
}

class ChangeDate extends AddSportEvent {
  ChangeDate(this.createdDate);

  final DateTime? createdDate;
}

class ChangeCategory extends AddSportEvent {
  ChangeCategory(this.category);

  final KeyValueModel? category;
}


class AddSport extends AddSportEvent {
  AddSport(this.title, this.createdDate, this.category);

  final String title;
  final DateTime? createdDate;
  final KeyValueModel category;
}
