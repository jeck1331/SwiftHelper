import 'package:flutter/material.dart';
import 'package:flutter_new_app/constants/constant_colors.dart';

import '../../widgets/home_form/home_form.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: ConstantColors.mainBgColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                      child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Swift Helper', textAlign: TextAlign.center, style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ))
                ],
              ),
              Column(
                children: [
                  Column(
                    children: const [
                      Text(
                        'Добро пожаловать!',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: HomeStartForm(),
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeAuthModule()));
                      //     },
                      //     child: const Text('Without auth'))
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                child: const Text(
                  'Илья Поляков 2023',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
