part of 'eat_list_bloc.dart';

abstract class EatListEvent {}

class EatInitEvent extends EatListEvent {
  EatInitEvent();
}

class SelectEvent extends EatListEvent {
  SelectEvent({required this.selectedId});

  final num selectedId;
}
