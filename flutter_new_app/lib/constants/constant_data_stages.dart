import 'package:flutter/material.dart';
import 'package:flutter_new_app/models/enums/stage_priority.dart';
import 'package:flutter_new_app/models/enums/stage_status.dart';

import '../models/key_value_model.dart';

class ConstantDataStages {
  static List<KeyValueModel> priorities = [
    KeyValueModel(key: StagePriority.empty.index, value: ConstantDataStages.getPriorityText(StagePriority.empty)),
    KeyValueModel(key: StagePriority.veryLow.index, value: ConstantDataStages.getPriorityText(StagePriority.veryLow)),
    KeyValueModel(key: StagePriority.low.index, value: ConstantDataStages.getPriorityText(StagePriority.low)),
    KeyValueModel(key: StagePriority.medium.index, value: ConstantDataStages.getPriorityText(StagePriority.medium)),
    KeyValueModel(key: StagePriority.high.index, value: ConstantDataStages.getPriorityText(StagePriority.high)),
    KeyValueModel(key: StagePriority.veryHigh.index, value: ConstantDataStages.getPriorityText(StagePriority.veryHigh))];

  static List<KeyValueModel> statuses = [
    KeyValueModel(key: StageStatus.empty.index, value: ConstantDataStages.getStatusText(StageStatus.empty)),
    KeyValueModel(key: StageStatus.active.index, value: ConstantDataStages.getStatusText(StageStatus.active)),
    KeyValueModel(key: StageStatus.completed.index, value: ConstantDataStages.getStatusText(StageStatus.completed)),
    KeyValueModel(key: StageStatus.canceled.index, value: ConstantDataStages.getStatusText(StageStatus.canceled))
  ];

  static String getStatusText(StageStatus status) {
    switch (status) {
      case StageStatus.active:
        return "Активен";
      case StageStatus.empty:
        return "Не активен";
      case StageStatus.canceled:
        return "Отменен";
      case StageStatus.completed:
        return "Выполнен";
    }
  }

  static String getPriorityText(StagePriority priority) {
    switch (priority) {
      case StagePriority.empty:
        return "Не имеет приоритета";
      case StagePriority.veryLow:
        return "Очень низкий";
      case StagePriority.low:
        return "Низкий";
      case StagePriority.medium:
        return "Средний";
      case StagePriority.high:
        return "Высокий";
      case StagePriority.veryHigh:
        return "Очень высокий";
    }
  }
}