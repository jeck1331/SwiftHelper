import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/constants/constant_colors.dart';
import 'package:flutter_new_app/extensions/text_styles.dart';
import 'package:flutter_new_app/screens/eat_list/eat_list.dart';
import 'package:flutter_new_app/screens/sport_list/sport_list.dart';

import '../../modules/home_auth/cubit/home_auth_nav_cubit.dart';

class HealthListItemWidget extends StatelessWidget {
  final String title;

  const HealthListItemWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {

    return Flexible(
        child: FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 1,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
                    return ConstantColors.mainMenuBtn;
                  } else {
                    return ConstantColors.mainBgColor;
                  }
                })
              ),
              onPressed: () => context.read<HomeAuthNavCubit>().changePageRoute(title == 'Питание' ? const EatListScreen() : const SportListScreen(), 'Здоровье', 2),
              child: Center(
                child: Text(title, style: const TextStyle().boldText28),
              ),
            )
        )
    );
  }
}
