import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_new_app/api/note_api.dart';
import 'package:flutter_new_app/models/enums/note_type.dart';

import '../../../models/api/note_item.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(const NoteListState()) {
    on<NoteListInitEvent>(_onGetData);
    on<SelectEvent>(_selectData);
  }

  _onGetData(NoteListInitEvent event, Emitter<NoteListState> emit) async {
    List<NoteItem> noteItems = await NoteApi().getAll();
    if (noteItems.isEmpty) {
      noteItems = List.generate(5, (index) => NoteItem(id: index, title: 'Запись $index', description: 'asdasdas 123 $index', createdDate: DateTime.now(), type: NoteType.note));
    }
    emit(state.copyWith(data: noteItems));
  }

  _selectData(SelectEvent event, Emitter<NoteListState> emit) async {
    emit(state.copyWith(selectedId: event.selectedId));
  }
}
