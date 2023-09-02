import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/models/api/health_eat_category.dart';
import 'package:rxdart/rxdart.dart';

class AddCategoryEatCubit extends Cubit<EatCategory?> {
  AddCategoryEatCubit() : super(null);

  void getData() => emit(EatCategory(id: 0, title: _title.value));

  final _title = BehaviorSubject<String>();

  //get
  Stream get titleStream => _title.stream.transform(validateTitle);

  //set
  Function(String) get changeTitle => _title.sink.add;


  void dispose() {
    _title.close();
  }

  final validateTitle = StreamTransformer<String, String>.fromHandlers(handleData: (accountName, sink) {
    sink.add(accountName);
  });
}
