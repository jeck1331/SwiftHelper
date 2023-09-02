part of 'entries_bloc.dart';

abstract class EntriesState {}

class AddNoteState extends EntriesState {
  AddNoteState(
      {this.id = 0,
      this.title = '',
      this.description = '',
      this.createdDate,
      this.type = NoteType.note,
      this.refUserId,
      this.refNoteId,
      this.noteDetailId});

  AddNoteState copyWith(
      {num? id,
      String? title,
      String? description,
      DateTime? createdDate,
      NoteType? type,
      num? refUserId,
      num? refNoteId,
      num? noteDetailId}) {
    return AddNoteState(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      type: type ?? this.type,
      refUserId: refUserId ?? this.refUserId,
      refNoteId: refNoteId ?? this.refNoteId,
      noteDetailId: noteDetailId ?? this.noteDetailId,
    );
  }

  final num id;
  final String title;
  final String description;
  final DateTime? createdDate;
  final NoteType type;
  final num? refUserId;
  final num? refNoteId;
  final num? noteDetailId;
}

class AddDetailNoteState extends EntriesState {}
