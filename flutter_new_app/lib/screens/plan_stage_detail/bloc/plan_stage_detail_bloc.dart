import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/plan_api.dart';
import 'package:flutter_new_app/constants/constant_data_stages.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/key_value_model.dart';

part 'plan_stage_detail_event.dart';

part 'plan_stage_detail_state.dart';

class PlanStageDetailBloc extends Bloc<PlanStageDetailEvent, PlanStageDetailInitialState> {
  PlanStageDetailBloc() : super(PlanStageDetailInitialState._(id: 0)) {
    on<PlanStageDetailInitialEvent>(_onInit);
    on<ChangeDate>(_onChangeDate);
    on<ChangeTitle>(_onChangeTitle);
    on<ChangeData>(_onChangeData);
    on<ChangeStatus>(_onChangeStatus);
    on<ChangePriority>(_onChangePriority);
    on<ChangeParentPlan>(_onChangeParentPlan);
  }

  final _data = BehaviorSubject<String>();
  final _title = BehaviorSubject<String>();

  //get
  Stream<String> get dataStream => _data.stream;
  Stream<String> get titleStream => _title.stream;

  //set
  Function(String) get changeData => _data.sink.add;
  Function(String) get changeTitle => _title.sink.add;

  void dispose() {
    _data.close();
    _title.close();
  }

  _onInit(PlanStageDetailInitialEvent event, Emitter<PlanStageDetailState> emit) async {
    var items = await PlanApi().getPlans();
    List<KeyValueModel> plans =
        List.generate(items.length, (index) => KeyValueModel(key: items[index].id, value: items[index].title));
    var currentItem = await PlanApi().getPlanEntry(event.id);

    if (currentItem != null) {
      emit(state.copyWith(
          id: event.id,
          title: currentItem.title,
          createdDate: currentItem.createdDate,
          data: currentItem.data,
          planId: event.planId,
          priority: ConstantDataStages.priorities.firstWhere((element) => element.key == currentItem.priority.index),
          status: ConstantDataStages.statuses.firstWhere((element) => element.key == currentItem.status.index),
          plans: plans));
    }
  }

  _onChangeDate(ChangeDate event, Emitter<PlanStageDetailInitialState> emit) async {
    emit(state.copyWith(createdDate: event.createdDate));
  }

  _onChangeStatus(ChangeStatus event, Emitter<PlanStageDetailInitialState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  _onChangePriority(ChangePriority event, Emitter<PlanStageDetailInitialState> emit) async {
    emit(state.copyWith(priority: event.priority));
  }

  _onChangeTitle(ChangeTitle event, Emitter<PlanStageDetailInitialState> emit) async {
    emit(state.copyWith(title: event.title));
  }

  _onChangeData(ChangeData event, Emitter<PlanStageDetailInitialState> emit) async {
    emit(state.copyWith(data: event.data));
  }

  _onChangeParentPlan(ChangeParentPlan event, Emitter<PlanStageDetailInitialState> emit) async {
    emit(state.copyWith(planId: event.planId));
  }
}
