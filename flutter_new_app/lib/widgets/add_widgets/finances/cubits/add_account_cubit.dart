import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/models/api/finance_account.dart';
import 'package:rxdart/rxdart.dart';

class AddAccountCubit extends Cubit<FinanceAccount?> {
  AddAccountCubit() : super(null);

  void getData() => emit(
    FinanceAccount(
      accountName: _accountName.value,
      valute: _valute.value));

  final _accountName = BehaviorSubject<String>();
  final _valute = BehaviorSubject<String>();

  //get
  Stream get accountNameStream => _accountName.stream.transform(validateAccountName);

  Stream get valuteStream => _valute.stream.transform(validateValute);

  //set
  Function(String) get changeAccountName => _accountName.sink.add;

  Function(String) get changeValute => _valute.sink.add;

  void dispose() {
    _accountName.close();
    _valute.close();
  }

  final validateAccountName = StreamTransformer<String, String>.fromHandlers(handleData: (accountName, sink) {
    sink.add(accountName);
  });
  final validateValute = StreamTransformer<String, String>.fromHandlers(handleData: (valute, sink) {
    sink.add(valute);
  });
}
