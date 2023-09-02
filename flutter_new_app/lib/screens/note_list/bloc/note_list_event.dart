part of 'note_list_bloc.dart';

abstract class NoteListEvent extends Equatable {}

class NoteListInitEvent extends NoteListEvent {
  @override
  List<Object?> get props => [];
}

class SelectEvent extends NoteListEvent {
  SelectEvent({required this.selectedId});

  final num selectedId;
  @override
  List<Object?> get props => [selectedId];
}