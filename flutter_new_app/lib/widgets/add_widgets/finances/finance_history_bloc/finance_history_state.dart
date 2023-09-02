part of 'finance_history_bloc.dart';

abstract class FinanceHistoryState extends Equatable {
  const FinanceHistoryState();

  @override
  List<Object> get props => [];
}

class FinanceHistoryInitial extends FinanceHistoryState {
  const FinanceHistoryInitial._(
      {this.itemName = '',
      this.type = FinanceHistoryType.expense,
      this.itemValue = 0,
      this.shopCategory = const KeyValueModel(key: 0, value: 'Пусто'),
      this.financeAccount = const KeyValueModel(key: 0, value: 'Пусто'),
      this.shopCategories = const [KeyValueModel(key: 0, value: 'Пусто')],
      this.financeAccounts = const [KeyValueModel(key: 0, value: 'Пусто')]});

  FinanceHistoryInitial copyWith(
      {String? itemName,
      num? itemValue,
      KeyValueModel? shopCategory,
      KeyValueModel? financeAccount,
      FinanceHistoryType? type,
      List<KeyValueModel>? shopCategories,
      List<KeyValueModel>? financeAccounts}) {
    return FinanceHistoryInitial._(
        itemName: itemName ?? this.itemName,
        itemValue: itemValue ?? this.itemValue,
        financeAccounts: financeAccounts ?? this.financeAccounts,
        type: type ?? this.type,
        shopCategory: shopCategory ?? this.shopCategory,
        shopCategories: shopCategories ?? this.shopCategories,
        financeAccount: financeAccount ?? this.financeAccount);
  }

  final String itemName;
  final num itemValue;
  final FinanceHistoryType type;
  final KeyValueModel shopCategory;
  final KeyValueModel financeAccount;
  final List<KeyValueModel> shopCategories;
  final List<KeyValueModel> financeAccounts;

  @override
  List<Object> get props => [itemName, itemValue, shopCategory, financeAccount, shopCategories, financeAccounts, type];
}
