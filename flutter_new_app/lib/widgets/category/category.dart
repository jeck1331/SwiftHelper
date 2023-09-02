import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_new_app/modules/home_auth/cubit/home_auth_nav_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constant_colors.dart';

class CategoryComponent extends StatelessWidget {
  final String imagePath;
  final String title;
  final int? newIndex;
  final Widget page;

  const CategoryComponent({super.key,
    required this.page,
    this.newIndex,
    required this.title,
    required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.8,
        alignment: FractionalOffset.center,
        child: BlocBuilder<HomeAuthNavCubit, HomeAuthNavState>(
          bloc: HomeAuthNavCubit(),
          builder: (context, state) {
            final cubit = context.read<HomeAuthNavCubit>();
            return ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll(ConstantColors.mainMenuBtn),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))))),
              onPressed: () {
                if (newIndex != null) {
                  cubit.changePageRoute(page, title, newIndex!);
                }
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: SvgPicture.asset(imagePath),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Text(title),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
