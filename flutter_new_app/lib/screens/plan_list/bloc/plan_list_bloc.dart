import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/plan_api.dart';
import 'package:flutter_new_app/models/api/plan_entry.dart';

part 'plan_list_event.dart';
part 'plan_list_state.dart';

class PlanListBloc extends Bloc<PlanListEvent, PlanListInitial> {
  PlanListBloc() : super(const PlanListInitial()) {
    on<PlanListInitEvent>(_onInit);
  }

  _onInit(PlanListInitEvent event, Emitter<PlanListInitial> emit) async {
    List<PlanEntry> planItems = await PlanApi().getPlans();
    if (planItems.isNotEmpty) {
      planItems.sort((b,a) => a.createdDate.compareTo(b.createdDate));
    }
    emit(state.copyWith(data: planItems));
  }
}
