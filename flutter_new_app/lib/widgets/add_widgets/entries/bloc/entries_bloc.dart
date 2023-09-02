import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/models/enums/note_type.dart';
import 'package:rxdart/rxdart.dart';

part 'entries_event.dart';
part 'entries_state.dart';

class AddEntriesBloc extends Bloc<EntriesEvent, AddNoteState> {
  AddEntriesBloc() : super(AddNoteState()) {
    on<AddEvent>(_update);
  }

  _update(AddEvent event, Emitter<AddNoteState> emit) async {
    emit(state.copyWith(
      id: event.id,
      title: event.title,
      description: event.description,
      createdDate: event.createdDate,
      noteDetailId: event.noteDetailId,
      refNoteId: event.refNoteId,
      refUserId: event.refUserId,
      type: event.type
    ));
  }

  final _title = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _type = BehaviorSubject<NoteType>();

  Stream<String> get titleStream => _title.stream.transform(titleValue);
  Stream<String> get descriptionStream => _description.stream.transform(descrValue);
  Stream<NoteType> get typeStream => _type.stream.transform(typeValue);

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(NoteType) get changeType => _type.sink.add;

  final titleValue = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    sink.add(value);
  });
  final descrValue = StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    sink.add(value);
  });
  final typeValue = StreamTransformer<NoteType, NoteType>.fromHandlers(handleData: (value, sink) {
    sink.add(value);
  });

  void dispose() {
    _title.close();
    _description.close();
    _type.close();
  }
}

// class AddDetailEntriesBloc extends Bloc<EntriesEvent, AddDetailNoteState> {
//   AddDetailEntriesBloc() : super(AddDetailNoteState()) {
//     on<AddInitEvent>(_onInit);
//   }
//
//   _onInit(AddDetailNoteState event, Emitter<AddNoteState> emit) async {
//
//   }
// }
