import 'package:flutter_new_app/models/enums/finance_type.dart';
import 'package:flutter_new_app/widgets/add_widgets/entries/add_entry.dart';
import 'package:flutter_new_app/widgets/add_widgets/health/add_category_eat.dart';
import 'package:flutter_new_app/widgets/add_widgets/health/add_category_sport.dart';
import 'package:flutter_new_app/widgets/add_widgets/health/add_sport.dart';
import 'package:flutter_new_app/widgets/add_widgets/plan/add_plan.dart';
import 'package:flutter_new_app/widgets/add_widgets/plan/add_stage.dart';

import '../models/enums/category_types.dart';
import 'package:flutter/material.dart';

import '../widgets/add_widgets/finances/add_account.dart';
import '../widgets/add_widgets/finances/add_category.dart';
import '../widgets/add_widgets/finances/add_history.dart';
import '../widgets/add_widgets/health/add_eat.dart';

class CreateEntityService {
  const CreateEntityService();

  Widget getViewWidget(CategoryType type, num key, num? planId, FinanceHistoryType? financeType) {
    switch (type) {
      case CategoryType.finance:
        return widgetFinanceOperation(key, financeType ?? FinanceHistoryType.expense);
      case CategoryType.health:
        return widgetHealthOperation(key);
      case CategoryType.plan:
        return widgetPlanOperation(key, planId);
      case CategoryType.note:
        return widgetNoteOperation(key);
    }
  }

  Widget widgetFinanceOperation(num key, FinanceHistoryType? type) {
    switch (key) {
      case 0:
        return const AddAccountWidget();
      case 2:
        return AddCategoryWidget();
      default:
        return AddHistoryWidget(type: type ?? FinanceHistoryType.expense);
    }
  }

  Widget widgetHealthOperation(num key) {
    switch (key) {
      case 0:
        return const AddEatWidget();
      case 1:
        return const AddSportWidget();
      case 2:
        return const AddCategoryEatWidget();
      case 3:
        return const AddCategorySportWidget();
      default:
        return const AddCategorySportWidget();
    }
  }

  Widget widgetPlanOperation(num key, num? planId) {
    switch (key) {
      case 0:
        return const AddPlanWidget();
      case 1:
        return AddStageWidget(planId: planId);
      default:
        return const AddPlanWidget();
    }
  }

  Widget widgetNoteOperation(num key) {
    switch (key) {
      case 0:
        return const AddEntryWidget();
      // case 3:
      //   return AddCategoryWidget();
      default:
        return const AddEntryWidget();
    }
  }
}
