import 'package:flutter_new_app/models/api/finance_account.dart';
import 'package:flutter_new_app/screens/finance_accounts/finance_account_imports.dart';

class FinanceAccountItem extends StatelessWidget {
  final FinanceAccount accountItem;

  const FinanceAccountItem({super.key, required this.accountItem});

  @override
  Widget build(BuildContext context) {
    TextStyle ts = const TextStyle();
    //final bloc = context.read<>
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(accountItem.accountName, style: ts.boldBlackText16),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.read<HomeAuthNavCubit>().changePageRoute(FinanceHistoryScreen(id: accountItem.id ?? -1), 'Финансы', 1),
                    child: const Text("История счета"),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () => null,
                        child: const Text("Изменить"),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
