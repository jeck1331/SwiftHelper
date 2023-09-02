import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/modules/categories/categories.dart';

part 'home_auth_nav_state.dart';

class HomeAuthNavCubit extends Cubit<HomeAuthNavState> {
  HomeAuthNavCubit() : super(const HomeAuthNavState(
    page: CategoriesModule(),
    title: 'Категории',
    isLoading: false,
    currentIndex: 0
  ));

  Future<void> changePageRoute(Widget page, String title, int newIndex) async =>
  emit(HomeAuthNavState(page: page, isLoading: false, title: title, currentIndex: newIndex));
}
