import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/constants/constant_data_stages.dart';
import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/extensions/text_styles.dart';

import '../../models/api/plan_stage_entry.dart';

class PlanStageItem extends StatelessWidget {
  const PlanStageItem({super.key, required this.stage});

  final PlanStageEntry stage;

  @override
  Widget build(BuildContext context) {
    TextStyle ts = const TextStyle();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 18, top: 18, left: 13, right: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(stage.title, style: ts.bigWhite),
            Text(ConstantDataStages.getStatusText(stage.status), style: ts.lightWhite)
            //color: StageStatus.values[stage.status.index] == StageStatus.active ? Color(233455),)
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 18, left: 13, right: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(stage.data, style: ts.lightGrey),
            Text(ConstantDataStages.getPriorityText(stage.priority), style: ts.lightWhite)
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                stage.createdDate.toNormalizedString,
                style: ts.lightWhite,
              )
            ],
          ))
    ]);
  }
}
