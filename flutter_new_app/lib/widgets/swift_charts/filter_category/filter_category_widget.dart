import 'package:flutter/material.dart';
import 'package:flutter_new_app/widgets/swift_charts/models/pie_item.dart';

class FilterCategoryWidget extends StatelessWidget {
  final PieItem pieItem;

  const FilterCategoryWidget({super.key, required this.pieItem});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: pieItem.color,
            maximumSize: const Size(140, 36),
            textStyle: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
            padding: const EdgeInsets.all(0)),
        onPressed: () => print(pieItem.title),
        child: Text(pieItem.title));
  }
}
