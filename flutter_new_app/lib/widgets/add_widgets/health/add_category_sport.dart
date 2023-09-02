import 'package:flutter_new_app/api/health_api.dart';
import 'package:flutter_new_app/models/api/health_activity_category.dart';

import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';
import 'cubits/add_category_sport_cubit.dart';


class AddCategorySportWidget extends StatelessWidget {
  const AddCategorySportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategorySportCubit(),
      child: BlocBuilder<AddCategorySportCubit, ActivityCategory?>(builder: (context, state) {
        final cubit = context.read<AddCategorySportCubit>();
        return IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: cubit.titleStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20, top: 20),
                              child: TextField(
                                  obscureText: false,
                                  onChanged: (text) {
                                    cubit.changeTitle(text);
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(
                                      labelTextStr: 'Категория физ. активности *', hintTextStr: 'Введите наименование категории')),
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
                          HealthApi().createSportCategory(cubit.state as ActivityCategory).then((value) {
                            if (value == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().info('Создана категория: ${cubit.state!.title}'));
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
