import 'package:flutter/material.dart';
import 'package:flutter_new_app/screens/plan_list/plan_list.dart';

import '../../constants/constant_colors.dart';

class PlansModule extends StatelessWidget {
  const PlansModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstantColors.mainBgColor,
      width: double.infinity,
      child: const PlanListScreen(),
    );
  }
}