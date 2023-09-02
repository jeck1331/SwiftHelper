import '../enums/note_type.dart';

class NoteItem {
  final num id;
  final String title;
  final String description;
  final DateTime? createdDate;
  final NoteType type;
  final num? refUserId;
  final num? refNoteId;
  final num? noteDetailId;

  const NoteItem(
      {required this.id,
      required this.title,
      required this.description,
      this.createdDate,
      required this.type,
      this.refNoteId,
      this.refUserId,
      this.noteDetailId});

  factory NoteItem.fromJson(Map<String, dynamic> json) {
    return NoteItem(
        id: json['id'] as num,
        title: json['title'] as String,
        description: json['description'] as String,
        createdDate: DateTime.parse(json['createdDate'] as String),
        type: NoteType.values[json['type'] as int],
        refNoteId: json['refNoteId'] as num?,
        refUserId: json['refUserId'] as num?,
        noteDetailId: json['noteDetailId'] as num?);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createdDate': formattingDate(createdDate ?? DateTime.now()),
        'type': type.index,
        'refNoteId': refNoteId,
        'refUserId': refUserId,
        'noteDetailId': noteDetailId
      };

  String formattingDate(DateTime date) =>
      '${date.year.toString()}-${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}-${date.day.toString()}';
}
