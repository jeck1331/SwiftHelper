part of 'note_list_bloc.dart';

class NoteListState extends Equatable {
  const NoteListState({this.data = const <NoteItem>[], this.selectedId});

  final List<NoteItem> data;
  final num? selectedId;

  NoteListState copyWith({List<NoteItem>? data, num? selectedId}) {
    return NoteListState(data: data ?? this.data, selectedId: selectedId ?? this.selectedId);
  }

  @override
  List<Object?> get props => [data, selectedId];
}
