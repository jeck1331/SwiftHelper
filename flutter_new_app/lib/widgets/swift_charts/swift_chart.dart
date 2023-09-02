import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/widgets/swift_charts/bloc/swift_chart_cubit.dart';

import 'base_chart/base_chart.dart';
import 'models/pie_item.dart';

class SwiftChart extends StatelessWidget {
  SwiftChart({super.key});

  List<PieItem> pieItems = [];

  @override
  Widget build(BuildContext context) {
    final cubit = context.select((SwiftChartCubit cubit) => cubit);

    return CustomPaint(
      painter: BaseChartPainter(categories: cubit.state, radius: 100),
      child: SizedBox(
        width: 150,
        height: 150,
        child: Container(
          padding: const EdgeInsets.only(left: 20, bottom: 25, right: 20),
          alignment: FractionalOffset.bottomLeft
        ),
      ),
    );
  }
}
