part of 'plan_list_bloc.dart';

abstract class PlanListEvent {}

class PlanListInitEvent extends PlanListEvent {

}

class SelectEvent extends PlanListEvent {
  SelectEvent({required this.selectedId});

  final num selectedId;
}
