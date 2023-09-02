part of 'plan_stage_detail_bloc.dart';

abstract class PlanStageDetailState {
  const PlanStageDetailState();
}

class PlanStageDetailInitialState extends PlanStageDetailState {
  PlanStageDetailInitialState._(
      {required this.id,
      this.title = '',
      this.createdDate,
      this.data = '',
      this.priority = const KeyValueModel(key: 0, value: 'Нет'),
      this.status = const KeyValueModel(key: 0, value: 'Не активен'),
      this.planId,
      this.plans});

  PlanStageDetailInitialState copyWith(
      {num? id,
      String? title,
      DateTime? createdDate,
      String? data,
      KeyValueModel? status,
      KeyValueModel? priority,
      num? planId,
      List<KeyValueModel>? plans}) {
    return PlanStageDetailInitialState._(
        id: id ?? this.id,
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
        data: data ?? this.data,
        planId: planId ?? this.planId,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        plans: plans ?? this.plans);
  }

  final String title;
  final num id;
  final String data;
  final DateTime? createdDate;
  final KeyValueModel? status;
  final KeyValueModel? priority;
  final num? planId;
  final List<KeyValueModel>? plans;
}
