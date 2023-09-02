import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/health_api.dart';
import 'package:flutter_new_app/models/api/health_eat.dart';

part 'eat_list_event.dart';
part 'eat_list_state.dart';

class EatListBloc extends Bloc<EatListEvent, EatInitialState> {
  EatListBloc() : super(EatInitialState()) {
    on<EatInitEvent>(_onGetData);
    on<SelectEvent>(_selectData);
  }

  _onGetData(EatInitEvent event, Emitter<EatInitialState> emit) async {
    List<Eat>? data = await HealthApi().getEats();

    if (data != null && data.isNotEmpty) {
      data.sort((b,a) => a.createdDate.compareTo(b.createdDate));
    }

    emit(state.copyWith(eatItems: data));
  }

  _selectData(SelectEvent event, Emitter<EatInitialState> emit) async {
    emit(state.copyWith(selectedId: event.selectedId));
  }
}
