import 'package:flutter/material.dart';
import 'package:flutter_new_app/constants/constant_colors.dart';
import 'package:flutter_new_app/screens/health_list/health_list.dart';

class HealthModule extends StatelessWidget {
  const HealthModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantColors.mainBgColor,
      width: double.infinity,
      child: const HealthListScreen(),
    );
  }
}
