import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/note_api.dart';
import 'package:flutter_new_app/models/api/note_detail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/enums/note_type.dart';

part 'note_detail_event.dart';

part 'note_detail_state.dart';

class NoteDetailBloc extends Bloc<NoteDetailEvent, NoteDetailInitial> {
  NoteDetailBloc() : super(NoteDetailInitial()) {
    on<NoteDetailInitEvent>(_onGetData);
    on<NoteDetailChangeText>(_update);
  }

  final _data = BehaviorSubject<String>();

  //get
  Stream<String> get dataStream => _data.stream;

  //set
  Function(String) get changeData => _data.sink.add;

  void dispose() {
    _data.close();
  }

  _update(NoteDetailChangeText event, Emitter<NoteDetailInitial> emit) async {
    emit(state.copyWith(data: event.text));
  }

  _onGetData(NoteDetailInitEvent event, Emitter<NoteDetailInitial> emit) async {
    NoteDetail? note;
    if (event.noteEntryId != null) {
      note = await NoteApi().getDetailNote(event.noteEntryId as num);
    }

    if (note != null) {
      changeData(note.data);
      emit(state.copyWith(id: note.id, data: note.data, type: note.type, noteEntryId: note.noteEntryId, createdDate: note.createdDate));
    } else {
      emit(state.copyWith(
          id: event.id,
          data: event.data,
          type: event.type,
          noteEntryId: event.noteEntryId,
          createdDate: event.createdDate));
    }
  }
}
