import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/health_api.dart';

import '../../../../models/key_value_model.dart';

part 'add_sport_event.dart';
part 'add_sport_state.dart';

class AddSportBloc extends Bloc<AddSportEvent, AddSportInitialState> {
  AddSportBloc() : super(const AddSportInitialState._()) {
    on<AddSportInitialEvent>(_onInit);
    on<ChangeDate>(_onChangeDate);
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeCategory>(_onChangeCategory);
  }

  _onInit(AddSportInitialEvent event, Emitter<AddSportInitialState> emit) async {
    var sportCategories = await HealthApi().getSportCategories();
    if (sportCategories != null) {
      List<KeyValueModel> categories = List.generate(sportCategories.length, (index) => KeyValueModel(key: sportCategories[index].id, value: sportCategories[index].title));
      emit(state.copyWith(
          title: event.title,
          createdDate: event.createdDate,
          categories: categories,
          category: categories[0]));
    }
  }

  _onChangeDate(ChangeDate event, Emitter<AddSportInitialState> emit) async {
    emit(state.copyWith(createdDate: event.createdDate));
  }

  _onChangeTitle(ChangeTitle event, Emitter<AddSportInitialState> emit) async {
    emit(state.copyWith(title: event.title));
  }

  _onChangeCategory(ChangeCategory event, Emitter<AddSportInitialState> emit) async {
    emit(state.copyWith(category: event.category));
  }
}
