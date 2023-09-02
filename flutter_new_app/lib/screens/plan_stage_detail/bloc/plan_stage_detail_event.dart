part of 'plan_stage_detail_bloc.dart';

abstract class PlanStageDetailEvent {}

class PlanStageDetailInitialEvent extends PlanStageDetailEvent {
  PlanStageDetailInitialEvent(this.planId, this.id);
  final num planId;
  final num id;
}

class ChangeTitle extends PlanStageDetailEvent {
  ChangeTitle(this.title);

  final String? title;
}

class ChangeDate extends PlanStageDetailEvent {
  ChangeDate(this.createdDate);

  final DateTime? createdDate;
}

class ChangeData extends PlanStageDetailEvent {
  ChangeData(this.data);

  final String? data;
}

class ChangePriority extends PlanStageDetailEvent {
  ChangePriority(this.priority);

  final KeyValueModel? priority;
}

class ChangeStatus extends PlanStageDetailEvent {
  ChangeStatus(this.status);

  final KeyValueModel? status;
}

class ChangeParentPlan extends PlanStageDetailEvent {
  ChangeParentPlan(this.planId);

  final num? planId;
}
