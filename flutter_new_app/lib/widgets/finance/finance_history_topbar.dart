import 'package:flutter_new_app/extensions/date_extension.dart';
import 'package:flutter_new_app/screens/finance_accounts/finance_account_imports.dart';

class FinanceHistoryTopbar extends StatelessWidget {
  const FinanceHistoryTopbar({super.key});

  int monthChange(int month, bool next) {
    if (next) {
      return month == DateTime.december ? month : month + 1;
    } else {
      return month == DateTime.january ? month : month - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final month = context.select((FinanceHistoriesBloc bloc) => bloc.state.month) ?? DateTime.now().month;
    return SizedBox(
      height: 50.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 25,
              width: 25,
              child: IconButton(
                  iconSize: 25,
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  onPressed: () => context.read<FinanceHistoriesBloc>().add(ChangeMonth(month: monthChange(month, false))),
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
            ),
          ),
          Text(month.toMonthChartString, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              height: 25,
              width: 25,
              child: IconButton(
                  iconSize: 25,
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  onPressed: () => context.read<FinanceHistoriesBloc>().add(ChangeMonth(month: monthChange(month, true))),
                  icon: const Icon(Icons.arrow_forward_ios_rounded)),
            ),
          ),
        ],
      ),
    );
  }
}
