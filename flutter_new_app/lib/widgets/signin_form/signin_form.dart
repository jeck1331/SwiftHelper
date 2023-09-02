import '../messengers/scaffold_messengers.dart';
import 'signin_imports.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignInCubit>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ConstantColors.mainBgColor,
        centerTitle: true,
        title: Row(
          children: [
            IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(ConstantTitles.SIGNIN),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
                stream: cubit.userNameStream,
                builder: (context, snapshot) {
                  return Flexible(
                      child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: TextField(
                                obscureText: false,
                                onChanged: (text) {
                                  cubit.changeUserName(text);
                                },
                                decoration: TextFormFieldStyle.textFieldStyle(
                                    labelTextStr: 'Имя пользователя *', hintTextStr: 'Введите имя пользователя')),
                          )));
                }),
            StreamBuilder(
                stream: cubit.passwordStream,
                builder: (context, snapshot) {
                  return Flexible(
                      child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextField(
                                obscureText: true,
                                onChanged: (text) {
                                  cubit.changePassword(text);
                                },
                                decoration: TextFormFieldStyle.textFieldStyle(
                                    labelTextStr: 'Пароль *', hintTextStr: 'Введите пароль')),
                          )));
                }),
            Flexible(
                child: FractionallySizedBox(
              widthFactor: 0.6,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(ConstantColors.mainBgColor),
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))))),
                  onPressed: () {
                    cubit.getData();
                    AuthApi().login(cubit.state as Login).then((value) {
                      if (value == 200) {
                        Navigator.pushNamedAndRemoveUntil(context, '/home_auth', (r) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().error);
                      }
                    });
                  },
                  child: const Text('Войти')),
            ))
          ],
        ),
      ),
    );
  }
}
