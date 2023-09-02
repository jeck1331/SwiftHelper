import 'dart:ui';

import 'package:flutter_new_app/models/finance_values_chart.dart';

import '../../../models/enums/finance_type.dart';

class PieItem {
  num sum = 0;
  final String title;
  final Color color;
  final List<FinanceValuesChart> values;

  PieItem(this.title, this.color, this.values) {
    for (var x in values) {
      if (x.type == FinanceHistoryType.expense) {
        sum += x.value;
      } else {
        sum -= x.value;
      }
    }
  }
}