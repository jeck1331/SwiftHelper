part of 'plan_bloc.dart';

abstract class PlanState {
  const PlanState();
}

class AddPlanInitialState extends PlanState {
  const AddPlanInitialState._({this.title = '', this.createdDate, this.description = ''});

  AddPlanInitialState copyWith({String? title, DateTime? createdDate, String? description}) {
    return AddPlanInitialState._(
        title: title ?? this.title,
        createdDate: createdDate ?? this.createdDate,
        description: description ?? this.description);
  }

  final String title;
  final String description;
  final DateTime? createdDate;
}
