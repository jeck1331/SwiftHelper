part of 'home_auth_nav_cubit.dart';

class HomeAuthNavState extends Equatable {
  final Widget page;
  final String title;
  final int currentIndex;
  final bool isLoading;

  const HomeAuthNavState({
    required this.page,
    this.currentIndex = 0,
    required this.title,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [page, isLoading];
}
