import 'package:equatable/equatable.dart';
import 'package:flutter_new_app/api/finance_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/api/finance_item.dart';

part 'finance_histories_event.dart';

part 'finance_histories_state.dart';

class FinanceHistoriesBloc extends Bloc<FinanceEvent, FinanceInitialState> {
  FinanceHistoriesBloc() : super(FinanceInitialState(accountId: -1)) {
    on<FinanceInitEvent>(_onGetData);
    on<SelectEvent>(_selectData);
    on<ChangeMonth>(_changeMonth);
  }

  _onGetData(FinanceInitEvent event, Emitter<FinanceInitialState> emit) async {
    List<FinanceItem>? data = event.id == -1 ? await FinanceApi().getAll() : await FinanceApi().getAllByAccount(event.id);

    if (data != null && data.isNotEmpty) {
      int month = state.month ?? DateTime.now().month;
      data = data.where((i) => i.createdDate.month == month).toList();
      data.sort((b, a) => a.createdDate.compareTo(b.createdDate));
    }

    emit(state.copyWith(financeItems: data, accountId: event.id));
  }

  _selectData(SelectEvent event, Emitter<FinanceInitialState> emit) async {
    emit(state.copyWith(selectedId: event.selectedId));
  }

  _changeMonth(ChangeMonth event, Emitter<FinanceInitialState> emit) async {
    List<FinanceItem>? data = state.accountId == -1 ? await FinanceApi().getAll() : await FinanceApi().getAllByAccount(state.accountId);

    if (data != null) {
      data = data.where((i) => i.createdDate.month == event.month).toList();
      data.sort((b, a) => a.createdDate.compareTo(b.createdDate));
    }

    emit(state.copyWith(month: event.month, financeItems: data));
  }
}
