part of 'note_detail_bloc.dart';

abstract class NoteDetailEvent {}

class NoteDetailInitEvent extends NoteDetailEvent {
  NoteDetailInitEvent({this.id, this.data, this.createdDate, this.type, this.noteEntryId});
  final num? id;
  final String? data;
  final DateTime? createdDate;
  final NoteType? type;
  final num? noteEntryId;
}

class NoteDetailChangeText extends NoteDetailEvent {
  NoteDetailChangeText(this.text);
  final String? text;
}