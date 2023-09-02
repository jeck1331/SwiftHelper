import '../enums/finance_type.dart';

class FinanceItem {
  final num id;
  final String itemName;
  final num itemValue;
  final DateTime createdDate;
  final FinanceHistoryType type;
  final String categoryShopName;
  final String accountValute;
  final String accountName;

  const FinanceItem(
      {required this.id,
      required this.itemName,
      required this.type,
      required this.createdDate,
      required this.itemValue,
      required this.categoryShopName,
      required this.accountName,
      required this.accountValute});

  factory FinanceItem.fromJson(Map<String, dynamic> json) {
    return FinanceItem(
        id: json['id'] as num,
        itemName: json['itemName'] as String,
        itemValue: json['itemValue'] as num,
        type: FinanceHistoryType.values[json['type'] as int],
        createdDate: DateTime.parse(json['createdDate'] as String),
        categoryShopName: json['categoryShopName'] as String,
        accountName: json['accountName'] as String,
        accountValute: json['accountValute'] as String);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'itemName': itemName,
        'type': type.index,
        'itemValue': itemValue,
        'createdDate': createdDate,
        'categoryShopName': categoryShopName,
        'accountName': accountName,
        'accountValute': accountValute
      };
}
