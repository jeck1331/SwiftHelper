import 'package:flutter_new_app/models/enums/stage_priority.dart';
import 'package:flutter_new_app/models/enums/stage_status.dart';

class PlanStageEntry {
  final num id;
  final String title;
  final String data;
  final StagePriority priority;
  final StageStatus status;
  final DateTime createdDate;
  final num planEntryId;

  PlanStageEntry(
      {required this.id,
      required this.title,
      required this.data,
      required this.priority,
      required this.status,
      required this.createdDate,
      required this.planEntryId});

  factory PlanStageEntry.fromJson(Map<String, dynamic> json) {
    return PlanStageEntry(
        id: json['id'] as num,
        title: json['title'] as String,
        data: json['data'] as String,
        priority: StagePriority.values[json['priority'] as int],
        status: StageStatus.values[json['status'] as int],
        createdDate: DateTime.parse(json['createdDate'] as String),
        planEntryId: json['planEntryId'] as num);
  }

  Map<String, dynamic> toJson() => {
        'id': id as int,
        'title': title,
        'data': data,
        'priority': priority.index,
        'status': status.index,
        'createdDate': formattingDate(createdDate ?? DateTime.now()),
        'planEntryId': planEntryId as int
      };

  String formattingDate(DateTime date) =>
      '${date.year.toString()}-${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}-${date.day.toString()}';
}
