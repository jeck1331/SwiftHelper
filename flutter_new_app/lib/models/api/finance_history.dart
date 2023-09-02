import '../enums/finance_type.dart';

class FinanceHistory {
  const FinanceHistory({required this.itemName, required this.itemValue, required this.categoryShopId, required this.accountId, required this.type});

  final String itemName;
  final FinanceHistoryType type;
  final num itemValue;
  final num categoryShopId;
  final num accountId;

  factory FinanceHistory.fromJson(Map<String, dynamic> json) {
    return FinanceHistory(
        itemName: json['itemName'] as String,
        type: FinanceHistoryType.values[json['type'] as int],
        itemValue: json['itemValue'] as num,
        categoryShopId: json['categoryShopId'] as num,
        accountId: json['accountId'] as num);
  }

  Map<String, dynamic> toJson() => {
    'itemName': itemName,
    'itemValue': itemValue,
    'type': type.index,
    'categoryShopId': categoryShopId,
    'accountId': accountId,
  };
}
