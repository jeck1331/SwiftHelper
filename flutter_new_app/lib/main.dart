import 'package:flutter_new_app/modules/add/add_imports.dart';
import 'package:flutter_new_app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: routes,
        debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: ConstantColors.mainBgColor,
      unselectedWidgetColor: ConstantColors.mainMenuBtn
    ));
  }
}
