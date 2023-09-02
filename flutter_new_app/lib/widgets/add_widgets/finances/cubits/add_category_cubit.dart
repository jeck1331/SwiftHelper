import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/constants/constant_colors.dart';
import 'package:flutter_new_app/models/key_color_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/api/finance_category.dart';

class AddCategoryCubit extends Cubit<FinanceCategory?> {
  AddCategoryCubit() : super(null);

  void getData() => emit(FinanceCategory(shopCategoryName: _shopCategoryName.value, icon: '', color: ChartColors.values[_color.value.key]));

  final _shopCategoryName = BehaviorSubject<String>();
  final _color = BehaviorSubject<KeyColorModel>();

  //get
  Stream get shopCategoryNameStream => _shopCategoryName.stream;
  Stream get colorStream => _color.stream;

  //set
  Function(String) get changeAccountName => _shopCategoryName.sink.add;
  Function(KeyColorModel) get changeColor => _color.sink.add;

  void dispose() {
    _shopCategoryName.close();
    _color.close();
  }
}
