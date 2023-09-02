import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';
import 'package:flutter_new_app/api/finance_api.dart';
import 'package:flutter_new_app/models/api/finance_account.dart';
import 'package:flutter_new_app/widgets/add_widgets/finances/cubits/add_account_cubit.dart';

class AddAccountWidget extends StatelessWidget {
  const AddAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAccountCubit(),
      child: BlocBuilder<AddAccountCubit, FinanceAccount?>(builder: (context, state) {
        final cubit = context.read<AddAccountCubit>();
        return IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: cubit.accountNameStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20, top: 20),
                              child: TextField(
                                  obscureText: false,
                                  onChanged: (text) {
                                    cubit.changeAccountName(text);
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(
                                      labelTextStr: 'Наименование счета *', hintTextStr: 'Введите наименование счета')),
                            )));
                  }),
              StreamBuilder(
                  stream: cubit.valuteStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextField(
                                  obscureText: false,
                                  onChanged: (text) {
                                    cubit.changeValute(text);
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(
                                      labelTextStr: 'Валюта', hintTextStr: 'Введите валюту')),
                            )));
                  }),
              Flexible(
                  child: FractionallySizedBox(
                widthFactor: 0.6,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(ConstantColors.mainBgColor),
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))))),
                    onPressed: () {
                      cubit.getData();
                      FinanceApi().createAccount(cubit.state as FinanceAccount).then((value) {
                        if (value == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info('Успешно создан финансовый счет: ${cubit.state!.accountName}"'));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().error);
                        }
                      });
                    },
                    child: const Text('Добавить')),
              ))
            ],
          ),
        );
      }),
    );
  }
}
