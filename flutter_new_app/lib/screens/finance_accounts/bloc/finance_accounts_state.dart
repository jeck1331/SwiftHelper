part of 'finance_accounts_bloc.dart';

class FinanceAccountState extends Equatable {
  const FinanceAccountState({this.data = const <FinanceAccount>[], this.selectedId});

  final List<FinanceAccount> data;
  final num? selectedId;

  FinanceAccountState copyWith({List<FinanceAccount>? data, num? selectedId}) {
    return FinanceAccountState(data: data ?? this.data, selectedId: selectedId ?? this.selectedId);
  }

  @override
  List<Object?> get props => [data, selectedId];
}
