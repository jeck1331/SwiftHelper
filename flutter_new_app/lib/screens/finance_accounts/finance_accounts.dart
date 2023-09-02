import 'package:flutter_new_app/api/finance_api.dart';
import 'package:flutter_new_app/models/api/finance_account.dart';
import 'package:flutter_new_app/screens/finance_accounts/bloc/finance_accounts_bloc.dart';
import 'package:flutter_new_app/widgets/modals/remove_modal.dart';

import '../../widgets/finance/finance_account_item.dart';
import '../../widgets/messengers/scaffold_messengers.dart';
import 'finance_account_imports.dart';

class FinanceAccountScreen extends StatelessWidget {
  const FinanceAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FinanceAccountsBloc()..add(FinanceAccountsInitEvent()),
        child: BlocBuilder<FinanceAccountsBloc, FinanceAccountState>(builder: (context, state) {
          final bloc = context.read<FinanceAccountsBloc>();
          return RefreshIndicator(
              onRefresh: () async => bloc.add(FinanceAccountsInitEvent()),
              child: Scaffold(
                  backgroundColor: ConstantColors.mainBgColor,
                  body: ListView.separated(
                    itemBuilder: (context, index) {
                      FinanceAccount data;
                      var isSelected =
                          state.selectedId != null && index != 0 && state.selectedId == state.data[index - 1].id;
                      if (index == 0) {
                        isSelected = state.selectedId == -1;
                        data = const FinanceAccount(accountName: 'Все счета', id: -1);
                      } else {
                        data = state.data[index - 1];
                      }

                      return InkWell(
                        child: Container(
                          color: isSelected ? Colors.lightBlueAccent : null,
                          child: ListTile(
                            key: ValueKey(data.id),
                            onTap: () {
                              context.read<HomeAuthNavCubit>()
                                  .changePageRoute(FinanceHistoryScreen(id: data.id ?? -1), 'Финансы', 1);
                              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => FinanceHistoryScreen(id: data.id ?? -1)));
                            },
                            onLongPress: () {
                              showDialog(
                                      context: context,
                                      builder: (context) => RemoveModalWidget(type: 0, entryId: data.id ?? -1))
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info(value as String));
                                if (value == 'Удачно') {
                                  bloc.add(FinanceAccountsInitEvent());
                                }
                              });
                            },
                            selected: isSelected,
                            title: FinanceAccountItem(accountItem: data),
                            minVerticalPadding: 2,
                            contentPadding: const EdgeInsets.all(0),
                          ),
                        ),
                      );
                    },
                    itemCount: state.data.length + 1,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 2,
                        color: Colors.white,
                      );
                    },
                  ),
                  bottomNavigationBar: Container(
                    color: ConstantColors.mainMenuBtn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddModule(categoryType: CategoryType.finance, keyType: 0)));
                              },
                              child: const Text('Добавить')),
                        )
                      ],
                    ),
                  )));
        }));
  }
}
