import 'package:flutter/material.dart';
import 'package:flutter_new_app/constants/constant_colors.dart';
import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/extensions/text_styles.dart';
import 'package:flutter_new_app/models/api/health_eat.dart';

class HealthEatItemWidget extends StatelessWidget {
  final Eat eat;

  const HealthEatItemWidget({super.key, required this.eat});

  @override
  Widget build(BuildContext context) {
    TextStyle ts = const TextStyle();
    return Container(
      color: ConstantColors.mainBgColor,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 12, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //SvgPicture.asset(financeItem., width: 50),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(eat.title, style: ts.boldText),
                        Text(eat.createdDate.timeToNormalizedString, style: ts.lightSmall)
                      ],
                    ),
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(right: 15, top: 10, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(eat.categoryName ?? '', style: ts.boldText),
                  Padding(padding: const EdgeInsets.only(top: 5),child: Text(eat.createdDate.toNormalizedString, style: ts.lightSmall),)
                ],
              ))
        ],
      ),
    );
  }
}
