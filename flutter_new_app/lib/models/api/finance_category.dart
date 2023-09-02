import 'package:flutter_new_app/constants/constant_colors.dart';

class FinanceCategory {
  final String shopCategoryName;
  final String? icon;
  final ChartColors? color;

  const FinanceCategory({required this.shopCategoryName, this.icon, this.color});

  factory FinanceCategory.fromJson(Map<String, dynamic> json) {
    return FinanceCategory(
        shopCategoryName: json['shopCategoryName'] as String,
        icon: json['icon'] as String?,
        color: ChartColors.values[json['color'] as int]);
  }

  Map<String, dynamic> toJson() => {'shopCategoryName': shopCategoryName, 'icon': icon, 'color': color!.index};
}
