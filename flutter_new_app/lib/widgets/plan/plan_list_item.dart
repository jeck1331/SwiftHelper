import 'package:flutter/cupertino.dart';
import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/extensions/text_styles.dart';
import 'package:flutter_new_app/models/api/plan_entry.dart';

class PlanListItem extends StatelessWidget {
  const PlanListItem({super.key, required this.plan});

  final PlanEntry plan;

  @override
  Widget build(BuildContext context) {
    TextStyle ts = const TextStyle();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         Padding(
           padding: const EdgeInsets.only(bottom: 10, top: 10, left: 5, right: 5),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(plan.title, style: ts.bigWhite)
             ],
           ),
         ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plan.description, style: ts.lightGrey),
                Text(plan.createdDate.toNormalizedString, style: ts.lightWhite,)
              ],
            ),
          )
        ],
      ),
    );
  }
}