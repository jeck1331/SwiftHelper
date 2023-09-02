import 'package:flutter_new_app/api/auth_api.dart';
import 'package:flutter_new_app/modules/plans/plans.dart';
import 'home_auth_imports.dart';

class HomeAuthModule extends StatelessWidget {
  const HomeAuthModule({super.key });

  @override
  Widget build(BuildContext context) {
    final changePageCubit = HomeAuthNavCubit();

    List<CategoriesModel> categories = <CategoriesModel>[
      CategoriesModel(page: const CategoriesModule(), title: 'Категории'),
      CategoriesModel(page: const FinanceModule(), title: 'Финансы'),
      CategoriesModel(page: const HealthModule(), title: 'Здоровье'),
      CategoriesModel(page: const NotesModule(), title: 'Заметки'),
      CategoriesModel(page: const PlansModule(), title: 'Планы')
    ];

    return BlocProvider<HomeAuthNavCubit>(
        create: (context) => changePageCubit,
        child: BlocBuilder<HomeAuthNavCubit, HomeAuthNavState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: ConstantColors.mainBgColor,
                  title: Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(state.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                     Row(
                       children: [
                         IconButton(onPressed: () => print('s'), icon: const Icon(Icons.person)),
                         IconButton(
                             onPressed: () {
                               AuthApi().logout();
                               Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
                             },
                             icon: const Icon(Icons.exit_to_app_rounded))
                       ],
                     ),
                    ]),
                  ),
                ),
                body: Center(
                  child: state.page,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.category), label: 'Категории', backgroundColor: ConstantColors.mainBgColor),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.monetization_on_outlined),
                        label: 'Финансы',
                        backgroundColor: ConstantColors.mainBgColor),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.health_and_safety_outlined),
                        label: 'Здоровье',
                        backgroundColor: ConstantColors.mainBgColor),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.sticky_note_2_outlined),
                        label: 'Заметки',
                        backgroundColor: ConstantColors.mainBgColor),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.access_time),
                        label: 'Планирование',
                        backgroundColor: ConstantColors.mainBgColor)
                  ],
                  currentIndex: state.currentIndex,
                  selectedItemColor: Colors.white,
                  onTap: (int index) {
                    changePageCubit.changePageRoute(categories[index].page, categories[index].title, index);
                  },
                  backgroundColor: ConstantColors.mainBgColor,
                ));
          },
        ));
  }
}
