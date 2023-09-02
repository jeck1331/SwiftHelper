import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/models/api/finance_item.dart';
import 'package:flutter_new_app/models/enums/finance_type.dart';
import 'package:flutter_new_app/screens/finance_accounts/finance_account_imports.dart';

class FinanceHistoryItem extends StatelessWidget {
  final FinanceItem financeItem;

  const FinanceHistoryItem({super.key, required this.financeItem});

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
                        Text(financeItem.itemName, style: ts.boldText),
                        Text(financeItem.categoryShopName, style: ts.mediumTextItem),
                        Text(financeItem.createdDate.timeToNormalizedString, style: ts.lightSmall)
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
                  Row(
                    children: [
                      Text('${financeItem.itemValue}',
                        style: financeItem.type == FinanceHistoryType.expense ? ts.greenText : ts.redText,
                      ),
                      Text(' ${financeItem.accountValute}',
                        style: ts.boldText,
                      ),
                    ],
                  ),
                  Text(
                    financeItem.accountName,
                    style: ts.mediumTextItem,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 5),child: Text(financeItem.createdDate.toNormalizedString, style: ts.lightSmall),)
                ],
              )),
        ],
      ),
    );
  }
}
