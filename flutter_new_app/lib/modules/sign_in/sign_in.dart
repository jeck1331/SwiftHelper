import 'sign_in_imports.dart';

class SignInModule extends StatelessWidget {
  const SignInModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: const SignInForm(),
    );
  }
}
