class FinanceAccount {
  final num? id;
  final String accountName;
  final String? valute;

  const FinanceAccount({required this.accountName, this.valute, this.id});

  factory FinanceAccount.fromJson(Map<String, dynamic> json) {
    return FinanceAccount(accountName: json['accountName'] as String, valute: json['valute'] as String, id: json['id'] as num);
  }

  Map<String, dynamic> toJson() => {'id': id ?? 0, 'accountName': accountName, 'valute': valute};
}
