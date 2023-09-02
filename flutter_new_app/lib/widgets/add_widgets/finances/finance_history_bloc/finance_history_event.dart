part of 'finance_history_bloc.dart';

abstract class FinanceHistoryEvent extends Equatable {}

class FinanceHistoryInitialEvent extends FinanceHistoryEvent {
  FinanceHistoryInitialEvent(this.itemName, this.itemValue, this.shopCategories, this.financeAccount,
      this.shopCategory, this.financeAccounts, this.type);

  final String? itemName;
  final num? itemValue;
  final FinanceHistoryType? type;
  final KeyValueModel? shopCategory;
  final KeyValueModel? financeAccount;
  final List<KeyValueModel> shopCategories;
  final List<KeyValueModel> financeAccounts;

  @override
  List<Object?> get props => [itemName, itemValue, shopCategory, financeAccounts, financeAccount, shopCategories, type];
}

class ChangeProductName extends FinanceHistoryEvent {
  ChangeProductName(this.itemName);

  final String? itemName;

  @override
  List<Object?> get props => [itemName];
}

class ChangeProductValue extends FinanceHistoryEvent {
  ChangeProductValue(this.itemValue);

  final num? itemValue;

  @override
  List<Object?> get props => [itemValue];
}

class ChangeShopCategory extends FinanceHistoryEvent {
  ChangeShopCategory(this.shopCategory);

  final KeyValueModel? shopCategory;

  @override
  List<Object?> get props => [shopCategory];
}

class ChangeFinanceAccount extends FinanceHistoryEvent {
  ChangeFinanceAccount(this.financeAccount);

  final KeyValueModel? financeAccount;

  @override
  List<Object?> get props => [financeAccount];
}


class AddFinanceHistory extends FinanceHistoryEvent {
  AddFinanceHistory(this.itemName, this.itemValue, this.shopCategory, this.financeAccount);

  final String itemName;
  final num itemValue;
  final KeyValueModel shopCategory;
  final KeyValueModel financeAccount;

  @override
  List<Object?> get props => [itemName, itemValue, shopCategory, financeAccount];
}

class ChangeType extends FinanceHistoryEvent {
  ChangeType(this.type);

  final FinanceHistoryType? type;

  @override
  List<Object?> get props => [type];
}
