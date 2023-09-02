import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/health_api.dart';

import '../../../../models/key_value_model.dart';

part 'add_eat_event.dart';
part 'add_eat_state.dart';

class AddEatBloc extends Bloc<AddEatEvent, AddEatInitialState> {
  AddEatBloc() : super(const AddEatInitialState._()) {
    on<AddEatInitialEvent>(_onInit);
    on<ChangeDate>(_onChangeDate);
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeCategory>(_onChangeCategory);
  }

  _onInit(AddEatInitialEvent event, Emitter<AddEatInitialState> emit) async {
    var eatCategories = await HealthApi().getEatCategories();
    if (eatCategories != null) {
      List<KeyValueModel> categories = List.generate(eatCategories.length, (index) => KeyValueModel(key: eatCategories[index].id, value: eatCategories[index].title));
      emit(state.copyWith(
          title: event.title,
          createdDate: event.createdDate,
          categories: categories,
          category: categories[0]));
    }
  }

  _onChangeDate(ChangeDate event, Emitter<AddEatInitialState> emit) async {
    emit(state.copyWith(createdDate: event.createdDate));
  }

  _onChangeTitle(ChangeTitle event, Emitter<AddEatInitialState> emit) async {
    emit(state.copyWith(title: event.title));
  }

  _onChangeCategory(ChangeCategory event, Emitter<AddEatInitialState> emit) async {
    emit(state.copyWith(category: event.category));
  }
}
