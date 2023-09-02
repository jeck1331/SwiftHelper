import 'modules/home/home.dart';
import 'modules/home_auth/home_auth.dart';

final routes = {
  '/': (context) => const HomeModule(),
  '/home_auth': (context) =>  const HomeAuthModule(),
  '/auth': (context) => const HomeModule(),
  '/register': (context) => const HomeModule()
};