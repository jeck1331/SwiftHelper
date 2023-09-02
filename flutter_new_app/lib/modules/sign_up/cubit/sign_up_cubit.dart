import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/extensions/string_validators.dart';
import 'package:flutter_new_app/models/api/register.dart';
import 'package:rxdart/rxdart.dart';

class SignUpCubit extends Cubit<Register?> {
  SignUpCubit() : super(null);

  getData() => Register(
      userName: _userName.value,
      password: _password.value,
      email: 'asdsa@m.ru',
      confirmPassword: _passwordRepeat.value);

  final _userName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _passwordRepeat = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();

  //get
  Stream get userNameStream => _userName.stream.transform(validateUserName);

  // Stream get emailStream => _email.stream.transform(validateEmail);

  Stream get passwordStream => _password.stream.transform(validatePassword);

  Stream get passwordRepeatStream =>
      _passwordRepeat.stream.transform(validatePassword).doOnData((String c) {
        if (0 != _password.value.compareTo(c)) {
          _passwordRepeat.addError("Пароли не совпадают!");
        }
      });

  //Stream get phoneStream => _phone.stream.transform(validatePhone);

  Stream<bool> get registerValid => Rx.combineLatest3(
      userNameStream,
      passwordStream,
      passwordRepeatStream,
      (a, b, c) => (0 == b.compareTo(c)));

  //set
  Function(String) get changeUserName => _userName.sink.add;

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeRepeatPassword => _passwordRepeat.sink.add;

  Function(String) get changePhone => _phone.sink.add;

  void dispose() {
    _userName.close();
    _email.close();
    _password.close();
    _passwordRepeat.close();
    _phone.close();
  }

  //Transformers
  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName.length < 6) {
      sink.addError('Имя пользователя заполнено неверно!');
    } else {
      sink.add(userName);
    }
  });
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (!EmailValidator.validate(email)) {
      sink.addError('Электронная почта заполнена неверно!');
    } else {
      sink.add(email);
    }
  });
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length < 6 ||
        !password.containsLowercase ||
        !password.containsUppercase ||
        !password.containsNumeric ||
        !password.containsSpecialSymbol) {
      sink.addError('Пароль неверно заполнен!');
    } else {
      sink.add(password);
    }
  });
  final validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone.length != 11) {
      sink.addError('Номер телефона неверно заполнен!');
    } else {
      sink.add(phone);
    }
  });
}
