import 'package:flutter/material.dart';
import 'package:flutter_new_app/api/finance_api.dart';
import 'package:flutter_new_app/api/health_api.dart';
import 'package:flutter_new_app/models/enums/category_types.dart';
import 'package:flutter_new_app/modules/add/add.dart';

class RemoveModalWidget extends StatelessWidget {
  const RemoveModalWidget({super.key, required this.type, this.title, required this.entryId});

  final int type;
  final String? title;
  final num entryId;

  @override
  Widget build(BuildContext context) {
    var textTitle = getTitleString(type);

    return AlertDialog(
      title: Text(textTitle),
      content: const Text('Выберите действие'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await deleteEntry(context, type, entryId);
          },
          child: const Text('Удалить'),
        ),
        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (builder) => const AddModule(keyType: 0, categoryType: CategoryType.finance)));
        //   },
        //   child: const Text('Изменить'),
        // ),
      ],
    );
  }

  String getTitleString(int type) {
    switch (type) {
      case 0:
        return 'Финансовый счет';
      case 1:
        return 'Элемент истории финансов';
      case 2:
        return 'Элемент питания';
      case 3:
        return 'Элемент физической активности';
      case 4:
        return 'Элемент истории финансов';
      case 5:
        return 'Элемент истории финансов';
      case 6:
        return 'Элемент истории финансов';
      default:
        return '';
    }
  }

  Future<void> deleteEntry(BuildContext context, int type, num entryId) async {
    switch (type) {
      case 0: //Счет
        var response = await FinanceApi().deleteAccount(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 1: //Элемент истории
        var response = await FinanceApi().deleteHistoryItem(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 2: //Еда
        var response = await HealthApi().deleteEat(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 3://Спорт
        var response = await HealthApi().deleteSport(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 4://
        var response = await FinanceApi().deleteHistoryItem(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 5://
        var response = await FinanceApi().deleteHistoryItem(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 6://
        var response = await FinanceApi().deleteHistoryItem(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 7://
        var response = await FinanceApi().deleteHistoryItem(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
      case 8://
        var response = await FinanceApi().deleteHistoryItem(entryId);
        if (response != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop("Удачно");
        }
        break;
    }
  }

  void changeEntry(int type) async {
    switch (type) {
      case 0:
        break;
    }
  }
}
