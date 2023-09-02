import 'sign_up_imports.dart';

class SignUpModule extends StatelessWidget {
  const SignUpModule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const RegisterForm(),
    );
  }
}
