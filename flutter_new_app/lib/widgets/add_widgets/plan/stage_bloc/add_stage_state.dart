part of 'add_stage_bloc.dart';

abstract class AddStageState {
  const AddStageState();
}

class AddStageInitialState extends AddStageState {
  AddStageInitialState._(
      {this.title = '',
      this.createdDate,
      this.data = '',
      this.priority = const KeyValueModel(key: 0, value: 'Нет'),
      this.status = const KeyValueModel(key: 0, value: 'Не активен'),
      this.planId,
      this.plans});

  AddStageInitialState copyWith(
      {String? title,
      DateTime? createdDate,
      String? data,
      KeyValueModel? status,
      KeyValueModel? priority,
      num? planId,
      List<KeyValueModel>? plans}) {
    return AddStageInitialState._(
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
        data: data ?? this.data,
        planId: planId ?? this.planId,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        plans: plans ?? this.plans);
  }

  final String title;
  final String data;
  final DateTime? createdDate;
  final KeyValueModel? status;
  final KeyValueModel? priority;
  final num? planId;
  final List<KeyValueModel>? plans;
}
