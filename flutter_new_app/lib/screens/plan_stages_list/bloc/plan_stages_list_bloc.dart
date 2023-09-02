import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/models/key_value_model.dart';

import '../../../api/plan_api.dart';
import '../../../models/api/plan_stage_entry.dart';

part 'plan_stages_list_event.dart';
part 'plan_stages_list_state.dart';

class PlanStagesListBloc extends Bloc<PlanStagesEvent, PlanStagesInitialState> {
  PlanStagesListBloc()
      : super(const PlanStagesInitialState(stages: [], filter: KeyValueModel(key: 0, value: 'Дата'), planId: 0)) {
    on<PlanStagesListInitEvent>(_onInit);
    on<ChangeFilter>(_onChangeFilter);
    on<ChangeSort>(_onChangeSort);
  }

  _onInit(PlanStagesListInitEvent event, Emitter<PlanStagesInitialState> emit) async {
    List<PlanStageEntry> stages = await PlanApi().getStages(event.planId);
    if (stages.isNotEmpty) {
      stages = sortingStages(state.filter, stages, state.sortByAsc);
    }
    emit(state.copyWith(stages: stages, planId: event.planId));
  }

  _onChangeFilter(ChangeFilter event, Emitter<PlanStagesInitialState> emit) async {
    List<PlanStageEntry> stages = sortingStages(event.filter, state.stages, state.sortByAsc);
    emit(state.copyWith(stages: stages, filter: event.filter));
  }

  _onChangeSort(ChangeSort event, Emitter<PlanStagesInitialState> emit) async {
    List<PlanStageEntry> stages = sortingStages(state.filter, state.stages, event.sort);
    emit(state.copyWith(stages: stages, sortByAsc: event.sort));
  }

  List<PlanStageEntry> sortingStages(KeyValueModel sort, List<PlanStageEntry> stages, bool sortBy) {
    switch (sort.key) {
      case 0:
        sortBy ? stages.sort((a, b) => a.createdDate.compareTo(b.createdDate)) : stages.sort((b, a) => a.createdDate.compareTo(b.createdDate));
        break;
      case 1:
        sortBy ? stages.sort((a, b) => a.priority.index.compareTo(b.priority.index)) : stages.sort((b, a) => a.priority.index.compareTo(b.priority.index));
        break;
      case 2:
        sortBy ? stages.sort((a, b) => a.status.index.compareTo(b.status.index)) : stages.sort((b, a) => a.status.index.compareTo(b.status.index));
        break;
    }
    return stages;
  }
}
