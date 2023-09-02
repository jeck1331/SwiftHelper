import 'package:flutter_new_app/widgets/swift_charts/models/pie_item.dart';

import '../../widgets/messengers/scaffold_messengers.dart';
import '../../widgets/modals/remove_modal.dart';
import '../../widgets/swift_charts/bloc/swift_chart_cubit.dart';
import 'finance_histories_import.dart';

class FinanceHistoryScreen extends StatelessWidget {
  const FinanceHistoryScreen({super.key, required this.id});

  final num id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FinanceHistoriesBloc>(create: (context) => FinanceHistoriesBloc()..add(FinanceInitEvent(id: id))),
        BlocProvider<SwiftChartCubit>(create: (context) => SwiftChartCubit()),
      ],
      child: FinanceHistoryScreenWidget(id: id),
    );
  }
}

class FinanceHistoryScreenWidget extends StatelessWidget {
  const FinanceHistoryScreenWidget({super.key, required this.id});

  final num id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FinanceHistoriesBloc, FinanceInitialState>(builder: (context, state) {
      final bloc = context.read<FinanceHistoriesBloc>();
      final cubit = context.read<SwiftChartCubit>();
      cubit.updateState(bloc.state.financeItems);
      return RefreshIndicator(
          onRefresh: () async {
            bloc.add(FinanceInitEvent(id: id));
            cubit.updateState(state.financeItems);
          },
          child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                      backgroundColor: ConstantColors.mainBgColor,
                      automaticallyImplyLeading: false,
                      floating: false,
                      pinned: true,
                      snap: false,
                      expandedHeight: 350,
                      title: const FinanceHistoryTopbar(),
                      flexibleSpace: FlexibleSpaceBar(
                        background: SizedBox(
                          height: 100,
                          width: 100,
                          child: BlocBuilder<SwiftChartCubit, List<PieItem>>(
                            bloc: cubit,
                            builder: (context, state) {
                              return SwiftChart();
                            },
                          ),
                        ),
                      )),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      List<FinanceItem> financeItems = state.financeItems;
                      FinanceItem data;
                      var isSelected = state.selectedId != null && state.selectedId == financeItems[index].id;

                      if (financeItems.isNotEmpty) {
                        data = financeItems[index];
                        return InkWell(
                          child: Container(
                            color: isSelected ? Colors.lightBlueAccent : null,
                            child: ListTile(
                              key: ValueKey(data.id),
                              onLongPress: () {
                                showDialog(context: context, builder: (context) => RemoveModalWidget(type: 1, entryId: data.id))
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info(value as String));
                                  if (value == 'Удачно') {
                                    bloc.add(FinanceInitEvent(id: id));
                                  }
                                });
                              },
                              selected: isSelected,
                              title: FinanceHistoryItem(financeItem: data),
                              minVerticalPadding: 0,
                              contentPadding: const EdgeInsets.all(0),
                            ),
                          ),
                        );
                      } else {
                        return const Center(child: Text('Нет данных'));
                      }
                    },
                    childCount: state.financeItems.isNotEmpty ? state.financeItems.length : 1,
                  ))
                ],
              ),
              bottomNavigationBar: Container(
                color: ConstantColors.mainBgColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: 0.4,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const AddModule(categoryType: CategoryType.finance, keyType: 1)));
                            },
                            child: const Text('Добавить')),
                      ),
                    ),
                  ],
                ),
              )));
    });
  }
}
