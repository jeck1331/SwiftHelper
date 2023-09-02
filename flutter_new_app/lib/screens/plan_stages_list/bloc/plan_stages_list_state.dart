part of 'plan_stages_list_bloc.dart';

abstract class PlanStagesState {
  const PlanStagesState();
}

class PlanStagesInitialState extends PlanStagesState {
  const PlanStagesInitialState(
      {required this.stages, this.selectedId, required this.filter, required this.planId, this.sortByAsc = false});

  final List<PlanStageEntry> stages;
  final num? selectedId;
  final num planId;
  final KeyValueModel filter;
  final bool sortByAsc;

  PlanStagesInitialState copyWith(
      {List<PlanStageEntry>? stages, num? selectedId, KeyValueModel? filter, num? planId, bool? sortByAsc}) {
    return PlanStagesInitialState(
        stages: stages ?? this.stages,
        selectedId: selectedId ?? this.selectedId,
        filter: filter ?? this.filter,
        planId: planId ?? this.planId,
        sortByAsc: sortByAsc ?? this.sortByAsc);
  }
}
