import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/api/finance_api.dart';

import '../../../models/api/finance_account.dart';

part 'finance_accounts_event.dart';
part 'finance_accounts_state.dart';

class FinanceAccountsBloc extends Bloc<FinanceAccountsEvent, FinanceAccountState> {
  FinanceAccountsBloc() : super(const FinanceAccountState()) {
    on<FinanceAccountsInitEvent>(_onGetData);
    on<SelectEvent>(_selectData);
  }

  _onGetData(FinanceAccountsInitEvent event, Emitter<FinanceAccountState> emit) async {
    List<FinanceAccount> financeAccounts = await FinanceApi().getFinanceAccounts();
    emit(state.copyWith(data: financeAccounts));
  }

  _selectData(SelectEvent event, Emitter<FinanceAccountState> emit) async {
    emit(state.copyWith(selectedId: event.selectedId));
  }
}