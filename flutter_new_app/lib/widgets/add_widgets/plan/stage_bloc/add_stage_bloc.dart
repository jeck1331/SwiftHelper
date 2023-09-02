import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/plan_api.dart';

import '../../../../models/key_value_model.dart';

part 'add_stage_event.dart';
part 'add_stage_state.dart';

class AddStageBloc extends Bloc<AddStageEvent, AddStageInitialState> {
  AddStageBloc() : super(AddStageInitialState._()) {
    on<AddStageInitialEvent>(_onInit);
    on<ChangeDate>(_onChangeDate);
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeData>(_onChangeData);
    on<ChangeStatus>(_onChangeStatus);
    on<ChangePriority>(_onChangePriority);
    on<ChangeParentPlan>(_onChangeParentPlan);
  }

  _onInit(AddStageInitialEvent event, Emitter<AddStageInitialState> emit) async {
    List<KeyValueModel> plans = [];
    if (event.planId != null) {
      var items = await PlanApi().getPlans();
      plans = List.generate(items.length, (index) => KeyValueModel(key: items[index].id, value: items[index].title));
    }
    emit(state.copyWith(
        title: event.title,
        createdDate: event.createdDate,
        data: event.data,
        planId: event.planId,
        priority: event.priority,
        status: event.status,
        plans: plans));
  }

  _onChangeDate(ChangeDate event, Emitter<AddStageInitialState> emit) async {
    emit(state.copyWith(createdDate: event.createdDate));
  }

  _onChangeStatus(ChangeStatus event, Emitter<AddStageInitialState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  _onChangePriority(ChangePriority event, Emitter<AddStageInitialState> emit) async {
    emit(state.copyWith(priority: event.priority));
  }

  _onChangeTitle(ChangeTitle event, Emitter<AddStageInitialState> emit) async {
    emit(state.copyWith(title: event.title));
  }

  _onChangeData(ChangeData event, Emitter<AddStageInitialState> emit) async {
    emit(state.copyWith(data: event.data));
  }

  _onChangeParentPlan(ChangeParentPlan event, Emitter<AddStageInitialState> emit) async {
    emit(state.copyWith(planId: event.planId));
  }
}
