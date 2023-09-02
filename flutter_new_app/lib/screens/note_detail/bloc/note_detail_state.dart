part of 'note_detail_bloc.dart';

abstract class NoteDetailState {}

class NoteDetailInitial extends NoteDetailState {
  NoteDetailInitial({this.id = 0, this.data = '', this.createdDate, this.type = NoteType.note, this.noteEntryId});

  final num id;
  final String data;
  final DateTime? createdDate;
  final NoteType type;
  final num? noteEntryId;

  NoteDetailInitial copyWith({
    num? id,
    String? data,
    DateTime? createdDate,
    NoteType? type,
    num? noteEntryId
}) {
    return NoteDetailInitial(
      id: id ?? this.id,
      data: data ?? this.data,
      createdDate: createdDate ?? this.createdDate,
      type: type ?? this.type,
      noteEntryId: noteEntryId ?? this.noteEntryId
    );
  }
}
