part of 'entries_bloc.dart';

abstract class EntriesEvent {}

class AddEvent extends EntriesEvent {
  AddEvent({this.id, this.title, this.description, this.createdDate, this.type, this.refUserId, this.refNoteId, this.noteDetailId});
  final num? id;
  final String? title;
  final String? description;
  final DateTime? createdDate;
  final NoteType? type;
  final num? refUserId;
  final num? refNoteId;
  final num? noteDetailId;
}

class AddDetailInitEvent extends EntriesEvent {

}
