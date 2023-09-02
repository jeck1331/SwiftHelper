part of 'plan_stages_list_bloc.dart';

abstract class PlanStagesEvent {}

class PlanStagesListInitEvent extends PlanStagesEvent {
  PlanStagesListInitEvent(this.planId);

  final num planId;
}

class ChangeFilter extends PlanStagesEvent {
  ChangeFilter(this.filter);

  final KeyValueModel filter;
}

class ChangeSort extends PlanStagesEvent {
  ChangeSort(this.sort);

  final bool sort;
}
