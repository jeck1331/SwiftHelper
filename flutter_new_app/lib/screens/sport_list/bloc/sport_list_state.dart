part of 'sport_list_bloc.dart';

abstract class SportListState {}

class SportInitialState extends SportListState {
  final List<LifeActivity> sportItems;
  final num? selectedId;

  SportInitialState({this.sportItems = const <LifeActivity>[], this.selectedId});

  SportInitialState copyWith({List<LifeActivity>? sportItems, num? selectedId}) {
    return SportInitialState(sportItems: sportItems ?? this.sportItems, selectedId: selectedId ?? this.selectedId);
  }
}

