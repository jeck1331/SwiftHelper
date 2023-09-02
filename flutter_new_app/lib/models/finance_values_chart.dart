import 'enums/finance_type.dart';

class FinanceValuesChart {
  const FinanceValuesChart(this.value, this.type);

  final num value;
  final FinanceHistoryType type;
}