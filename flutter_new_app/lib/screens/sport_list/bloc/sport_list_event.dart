part of 'sport_list_bloc.dart';

abstract class SportListEvent {}

class SportInitEvent extends SportListEvent {
  SportInitEvent();
}

class SelectEvent extends SportListEvent {
  SelectEvent({required this.selectedId});

  final num selectedId;
}
