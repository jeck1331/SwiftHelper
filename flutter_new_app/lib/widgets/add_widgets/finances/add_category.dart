import 'package:flutter_new_app/models/key_color_model.dart';
import 'package:flutter_new_app/widgets/item_color/item_color.dart';

import '../../../api/finance_api.dart';
import '../../messengers/scaffold_messengers.dart';
import '../add_widget_imports.dart';
import 'package:flutter_new_app/models/api/finance_category.dart';
import 'package:flutter_new_app/widgets/add_widgets/finances/cubits/add_category_cubit.dart';

class AddCategoryWidget extends StatelessWidget {
  AddCategoryWidget({super.key});

  List<DropdownMenuItem<KeyColorModel>> colorItems = List.generate(
      ConstantColors.colorForChart.length,
      (index) {
        print(index);
        return DropdownMenuItem<KeyColorModel>(
            value: KeyColorModel(key: index, color: ConstantColors.colorForChart[index]),
            child: ItemColor(keyColor: index));
      });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit(),
      child: BlocBuilder<AddCategoryCubit, FinanceCategory?>(builder: (context, state) {
        final cubit = context.read<AddCategoryCubit>();
        return IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: cubit.shopCategoryNameStream,
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
                                      labelTextStr: 'Наименование категории *',
                                      hintTextStr: 'Введите наименование категории')),
                            )));
                  }),
              StreamBuilder(
                  stream: cubit.colorStream,
                  builder: (context, snapshot) {
                    KeyColorModel? model = snapshot.hasData ? snapshot.data : colorItems[0].value;

                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: DropdownButtonFormField<KeyColorModel>(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(gapPadding: 0.0),
                                ),
                                isExpanded: true,
                                items: colorItems,
                                value: model,
                                onChanged: (value) {
                                  if (value != null) {
                                    cubit.changeColor(value);
                                  }
                                },
                              ),
                              // child: TextField(
                              //     obscureText: false,
                              //     onChanged: (text) {
                              //       cubit(text);
                              //     },
                              //     decoration: TextFormFieldStyle.textFieldStyle(labelTextStr: 'Иконка', hintTextStr: 'Выберите иконку')),
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
                    onPressed: () async {
                      cubit.getData();
                      var res = await FinanceApi().createShopCategory(cubit.state as FinanceCategory);
                      ScaffoldMessenger.of(context).showSnackBar(
                          res != null ? ScaffoldMessengers().info('Успешно создана категория: ${cubit.state!.shopCategoryName}"') :
                          ScaffoldMessengers().error);
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
