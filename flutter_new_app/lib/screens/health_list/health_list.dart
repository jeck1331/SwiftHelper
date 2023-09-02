import 'package:flutter/material.dart';
import 'package:flutter_new_app/widgets/health/health_list_item.dart';

class HealthListScreen extends StatelessWidget {
  const HealthListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        HealthListItemWidget(title: 'Питание'),
        HealthListItemWidget(title: 'Физическая активность'),
      ],
    );
  }
}