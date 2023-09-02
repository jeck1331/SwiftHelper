part of 'add_stage_bloc.dart';

abstract class AddStageEvent {}

class AddStageInitialEvent extends AddStageEvent {
  AddStageInitialEvent(this.title, this.createdDate, this.data, this.planId, this.status, this.priority);

  final String? title;
  final String? data;
  final DateTime? createdDate;
  final KeyValueModel? status;
  final KeyValueModel? priority;
  final num? planId;
}

class ChangeTitle extends AddStageEvent {
  ChangeTitle(this.title);

  final String? title;
}

class ChangeDate extends AddStageEvent {
  ChangeDate(this.createdDate);

  final DateTime? createdDate;
}

class ChangeData extends AddStageEvent {
  ChangeData(this.data);

  final String? data;
}

class ChangePriority extends AddStageEvent {
  ChangePriority(this.priority);

  final KeyValueModel? priority;
}

class ChangeStatus extends AddStageEvent {
  ChangeStatus(this.status);

  final KeyValueModel? status;
}

class ChangeParentPlan extends AddStageEvent {
  ChangeParentPlan(this.planId);

  final num? planId;
}
