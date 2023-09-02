import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/health_api.dart';
import '../../../models/api/health_life_activity.dart';

part 'sport_list_event.dart';
part 'sport_list_state.dart';

class SportListBloc extends Bloc<SportListEvent, SportInitialState> {
  SportListBloc() : super(SportInitialState()) {
    on<SportInitEvent>(_onGetData);
    on<SelectEvent>(_selectData);
  }

  _onGetData(SportInitEvent event, Emitter<SportInitialState> emit) async {
    List<LifeActivity>? data = await HealthApi().getSports();

    if (data != null && data.isNotEmpty) {
      data.sort((b,a) => a.createdDate.compareTo(b.createdDate));
    }

    emit(state.copyWith(sportItems: data));
  }

  _selectData(SelectEvent event, Emitter<SportInitialState> emit) async {
    emit(state.copyWith(selectedId: event.selectedId));
  }
}
