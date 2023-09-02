part of 'eat_list_bloc.dart';

abstract class EatListState {}

class EatInitialState extends EatListState {
  final List<Eat> eatItems;
  final num? selectedId;

  EatInitialState({this.eatItems = const <Eat>[], this.selectedId});

  EatInitialState copyWith({List<Eat>? eatItems, num? selectedId}) {
    return EatInitialState(eatItems: eatItems ?? this.eatItems, selectedId: selectedId ?? this.selectedId);
  }
}

