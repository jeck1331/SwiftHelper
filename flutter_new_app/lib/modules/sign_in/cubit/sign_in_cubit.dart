import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/extensions/string_validators.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/api/login.dart';


class SignInCubit extends Cubit<Login?> {
  SignInCubit() : super(null);


  void getData() => emit(
      Login(
          userName: _userName.value,
          password: _password.value,
      )
  );

  final _userName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //get
  Stream get userNameStream => _userName.stream.transform(validateUserName);

  Stream get passwordStream => _password.stream.transform(validatePassword);

  Stream<bool> get registerValid =>
      Rx.combineLatest2(
          userNameStream, passwordStream, (a, b) => true);

  //set
  Function(String) get changeUserName => _userName.sink.add;

  Function(String) get changePassword => _password.sink.add;


  void dispose() {
    _userName.close();
    _password.close();
  }

  //Transformers
  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
        if (userName.length < 6) {
          sink.addError('UserName length is not valid!');
        } else {
          sink.add(userName);
        }
      }
  );
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length < 6 || !password.containsLowercase ||
            !password.containsUppercase
            || !password.containsNumeric || !password.containsSpecialSymbol) {
          sink.addError('Password is not valid!');
        } else {
          sink.add(password);
        }
      }
  );
}
