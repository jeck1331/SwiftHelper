import '../enums/note_type.dart';

class NoteDetail {
  final num id;
  final String data;
  final DateTime? createdDate;
  final NoteType type;
  final num? noteEntryId;

  NoteDetail({required this.id, required this.data, this.createdDate, required this.type, this.noteEntryId});

  factory NoteDetail.fromJson(Map<String, dynamic> json) {
    return NoteDetail(
        id: json['id'] as num,
        data: json['data'] as String,
        createdDate: DateTime.parse(json['createdDate'] as String),
        type: NoteType.values[json['type'] as int],
        noteEntryId: json['noteEntryId'] as num);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'data': data,
        'createdDate': formattingDate(createdDate ?? DateTime.now()),
        'type': type.index,
        'noteEntryId': noteEntryId
      };

  String formattingDate(DateTime date) =>
      '${date.year.toString()}-${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}-${date.day.toString()}';
}
