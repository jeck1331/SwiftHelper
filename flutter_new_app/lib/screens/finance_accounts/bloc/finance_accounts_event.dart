part of 'finance_accounts_bloc.dart';

abstract class FinanceAccountsEvent extends Equatable {}

class FinanceAccountsInitEvent extends FinanceAccountsEvent {
  @override
  List<Object?> get props => [];
}

class SelectEvent extends FinanceAccountsEvent {
  SelectEvent({required this.selectedId});

  final num selectedId;
  @override
  List<Object?> get props => [selectedId];
}