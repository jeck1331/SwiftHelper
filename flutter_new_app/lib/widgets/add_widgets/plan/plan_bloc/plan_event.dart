part of 'plan_bloc.dart';

abstract class PlanEvent {}

class AddPlanInitialEvent extends PlanEvent {
  AddPlanInitialEvent(this.title, this.createdDate, this.description);

  final String? title;
  final String? description;
  final DateTime? createdDate;
}

class ChangeTitle extends PlanEvent {
  ChangeTitle(this.title);

  final String? title;
}

class ChangeDate extends PlanEvent {
  ChangeDate(this.createdDate);

  final DateTime? createdDate;
}

class ChangeDescription extends PlanEvent {
  ChangeDescription(this.description);

  final String? description;
}
