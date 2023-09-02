part of 'finance_histories_bloc.dart';

abstract class FinanceState extends Equatable {}

class FinanceInitialState extends FinanceState {
  final List<FinanceItem> financeItems;
  final num? selectedId;
  final int? month;
  final num accountId;

  FinanceInitialState({this.financeItems = const <FinanceItem>[], this.selectedId, this.month, required this.accountId});

  FinanceInitialState copyWith({List<FinanceItem>? financeItems, num? selectedId, int? month, num? accountId}) {
    return FinanceInitialState(
        financeItems: financeItems ?? this.financeItems,
        selectedId: selectedId ?? this.selectedId,
        month: month ?? this.month,
        accountId: accountId ?? this.accountId);
  }

  @override
  List<Object> get props => [financeItems, selectedId ?? 0, month ?? DateTime.now().month, accountId ?? -1];
}
