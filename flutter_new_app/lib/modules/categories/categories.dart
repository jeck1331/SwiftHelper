import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/constants/constant_svgs.dart';
import 'package:flutter_new_app/modules/health/health.dart';
import 'package:flutter_new_app/modules/home_auth/cubit/home_auth_nav_cubit.dart';
import 'package:flutter_new_app/modules/notes/notes.dart';
import 'package:flutter_new_app/widgets/category/category.dart';

import '../../constants/constant_colors.dart';
import '../finance/finance.dart';
import '../plans/plans.dart';

class CategoriesModule extends StatelessWidget {
  const CategoriesModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeAuthNavCubit, HomeAuthNavState>(
        bloc: HomeAuthNavCubit(),
        builder: (context, state) {
          return Container(
            color: ConstantColors.mainBgColor,
            width: double.infinity,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryComponent(
                    page: FinanceModule(),
                    title: 'Финансы',
                    newIndex: 1,
                    imagePath: ConstantSvgs.finance),
                CategoryComponent(
                    page: HealthModule(),
                    title: 'Здоровье',
                    newIndex: 2,
                    imagePath: ConstantSvgs.health),
                CategoryComponent(
                    page: NotesModule(),
                    title: 'Заметки',
                    newIndex: 3,
                    imagePath: ConstantSvgs.notes),
                CategoryComponent(
                    page: PlansModule(),
                    title: 'Планирование',
                    newIndex: 4,
                    imagePath: ConstantSvgs.time)
              ],
            ),
          );
        });
  }
}
