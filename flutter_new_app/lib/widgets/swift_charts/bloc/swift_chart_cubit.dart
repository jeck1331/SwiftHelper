import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/models/finance_values_chart.dart';

import '../../../api/finance_api.dart';
import '../../../constants/constant_colors.dart';
import '../../../models/api/finance_item.dart';
import '../models/pie_item.dart';

class SwiftChartCubit extends Cubit<List<PieItem>> {
  SwiftChartCubit() : super([]);

  void updateState(List<FinanceItem> financeItems) async {
    List<PieItem> pieItems = await getCategoriesFromHistory(financeItems);
    emit(pieItems);
  }

  Future<List<PieItem>> getCategoriesFromHistory(List<FinanceItem> financeItems) async {
    List<num> ids = List.generate(financeItems.length, (index) => financeItems[index].id);
    var value = await FinanceApi().getCategoriesById(ids);

    if (value.isNotEmpty) {
      return List.generate(value.length, (index)
      {
        List<FinanceItem> items = financeItems.where((e) => e.categoryShopName == value[index].shopCategoryName).toList();
        return PieItem(value[index].shopCategoryName,
            ConstantColors.colorForChart[value[index].color!.index],
            List.generate(items.length, (index) => FinanceValuesChart(items[index].itemValue, items[index].type)));
      });
    }

    return [];
  }
}
