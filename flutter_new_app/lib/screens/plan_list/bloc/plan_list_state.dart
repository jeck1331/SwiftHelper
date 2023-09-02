part of 'plan_list_bloc.dart';

abstract class PlanListState {
  const PlanListState();
}

class PlanListInitial extends PlanListState {
  const PlanListInitial({this.data = const <PlanEntry>[], this.selectedId});

  final List<PlanEntry> data;
  final num? selectedId;

  PlanListInitial copyWith({List<PlanEntry>? data, num? selectedId}) {
    return PlanListInitial(data: data ?? this.data, selectedId: selectedId ?? this.selectedId);
  }
}
