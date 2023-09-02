import 'package:flutter_bloc/flutter_bloc.dart';

part 'plan_event.dart';

part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, AddPlanInitialState> {
  PlanBloc() : super(const AddPlanInitialState._()) {
    on<AddPlanInitialEvent>(_onInit);
    on<ChangeDate>(_onChangeDate);
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeDescription>(_onChangeDescription);
  }

  _onInit(AddPlanInitialEvent event, Emitter<AddPlanInitialState> emit) async {
    emit(state.copyWith(title: event.title, createdDate: event.createdDate, description: event.description));
  }

  _onChangeDate(ChangeDate event, Emitter<AddPlanInitialState> emit) async {
    emit(state.copyWith(createdDate: event.createdDate));
  }

  _onChangeTitle(ChangeTitle event, Emitter<AddPlanInitialState> emit) async {
    emit(state.copyWith(title: event.title));
  }

  _onChangeDescription(ChangeDescription event, Emitter<AddPlanInitialState> emit) async {
    emit(state.copyWith(description: event.description));
  }
}
