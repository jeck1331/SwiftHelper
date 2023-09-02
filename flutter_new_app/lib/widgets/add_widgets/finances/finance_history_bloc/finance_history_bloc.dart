import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/finance_api.dart';

import '../../../../models/enums/finance_type.dart';
import '../../../../models/key_value_model.dart';

part 'finance_history_event.dart';
part 'finance_history_state.dart';

class FinanceHistoryBloc extends Bloc<FinanceHistoryEvent, FinanceHistoryInitial> {
  FinanceHistoryBloc() : super(const FinanceHistoryInitial._()) {
    on<FinanceHistoryInitialEvent>(_onInit);
    on<ChangeProductName>(_onChangeProductName);
    on<ChangeProductValue>(_onChangeProductValue);
    on<ChangeShopCategory>(_onChangeShopCategory);
    on<ChangeFinanceAccount>(_onChangeFinanceAccount);
    on<ChangeType>(_onChangeType);
  }

  _onInit(FinanceHistoryInitialEvent event, Emitter<FinanceHistoryInitial> emit) async {
    List<KeyValueModel> shopCategories = await FinanceApi().getShopCategories();
    List<KeyValueModel> financeAccounts = await FinanceApi().getAccountsKeyValue();
    emit(state.copyWith(
        itemName: event.itemName,
        itemValue: event.itemValue,
        type: event.type,
        financeAccount: financeAccounts[0],
        shopCategories: shopCategories,
        shopCategory: shopCategories[0],
        financeAccounts: financeAccounts));
  }

  _onChangeType(ChangeType event, Emitter<FinanceHistoryInitial> emit) async {
    emit(state.copyWith(type: event.type));
  }

  _onChangeProductName(ChangeProductName event, Emitter<FinanceHistoryInitial> emit) async {
    emit(state.copyWith(itemName: event.itemName));
  }

  _onChangeProductValue(ChangeProductValue event, Emitter<FinanceHistoryInitial> emit) async {
    emit(state.copyWith(itemValue: event.itemValue));
  }

  _onChangeShopCategory(ChangeShopCategory event, Emitter<FinanceHistoryInitial> emit) async {
    emit(state.copyWith(shopCategory: event.shopCategory));
  }

  _onChangeFinanceAccount(ChangeFinanceAccount event, Emitter<FinanceHistoryInitial> emit) async {
    emit(state.copyWith(financeAccount: event.financeAccount));
  }
}
