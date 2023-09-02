import 'package:flutter/material.dart';
import 'package:flutter_new_app/constants/constant_colors.dart';
import 'package:flutter_new_app/modules/sign_in/sign_in.dart';
import 'package:flutter_new_app/modules/sign_up/sign_up.dart';

class HomeStartForm extends StatelessWidget {
  const HomeStartForm({super.key});

  @override
  Widget build(BuildContext context) {
    Widget loginButton = ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInModule()));
        },
        style: btnStyle,
        child: const Text(
          'Вход',
          style: TextStyle(fontSize: 20),
        ));

    Widget registerButton = ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpModule()));
        },
        style: btnStyle,
        child: const Text(
            'Регистрация',
          style: TextStyle(fontSize: 20),
        ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: loginButton,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 35, right: 35),
          child: registerButton,
        ),
      ],
    );
  }
}

ButtonStyle btnStyle = ElevatedButton.styleFrom(
    fixedSize: Size(400, 50),
    backgroundColor: ConstantColors.mainMenuBtn,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))));
