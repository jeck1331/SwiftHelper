import 'package:flutter/cupertino.dart';

import '../../constants/constant_colors.dart';

class ItemColor extends StatelessWidget {
  const ItemColor({super.key, required this.keyColor});

  final int keyColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 250,
            height: 20,
            color: ConstantColors.colorForChart[keyColor])
      ],
    );
  }
}
