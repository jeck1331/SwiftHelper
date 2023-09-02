part of 'finance_histories_bloc.dart';

abstract class FinanceEvent extends Equatable {}

class FinanceInitEvent extends FinanceEvent {
  FinanceInitEvent({required this.id});
  final num id;

  @override
  List<Object> get props => [id];
}

class SelectEvent extends FinanceEvent {
  SelectEvent({required this.selectedId});

  final num selectedId;
  @override
  List<Object?> get props => [selectedId];
}

class ChangeMonth extends FinanceEvent {
  ChangeMonth({required this.month});

  final int month;
  @override
  List<Object?> get props => [month];
}
