import '../messengers/scaffold_messengers.dart';
import 'register_imports.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignUpCubit>(context, listen: false);
    final formKey = GlobalKey<FormState>();

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
              child: Text(ConstantTitles.SIGNUP),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              StreamBuilder(
                  stream: bloc.userNameStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20, top: 20),
                              child: TextFormField(
                                  obscureText: false,
                                  onChanged: (text) {
                                    bloc.changeUserName(text);
                                  },
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Заполните поле";
                                    }
                                    if (snapshot.hasError) {
                                      return snapshot.error.toString();
                                    }
                                    return null;
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(labelTextStr: 'Имя пользователя *', hintTextStr: 'Введите имя пользователя')),
                            )));
                  }),
              StreamBuilder(
                  stream: bloc.passwordStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                  obscureText: true,
                                  onChanged: (text) {
                                    bloc.changePassword(text);
                                  },
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Заполните поле";
                                    }
                                    if (snapshot.hasError) {
                                      return snapshot.error.toString();
                                    }
                                    return null;
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(labelTextStr: 'Пароль *', hintTextStr: 'Введите пароль')),
                            )));
                  }),
              StreamBuilder(
                  stream: bloc.passwordRepeatStream,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                  obscureText: true,
                                  onChanged: (text) {
                                    bloc.changeRepeatPassword(text);
                                  },
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "Заполните поле";
                                    }
                                    if (snapshot.hasError) {
                                      return snapshot.error.toString();
                                    }
                                    return null;
                                  },
                                  decoration: TextFormFieldStyle.textFieldStyle(labelTextStr: 'Повторите пароль *', hintTextStr: 'Введите пароль повторно')),
                            )));
                  }),
              StreamBuilder(
                  stream: bloc.registerValid,
                  builder: (context, snapshot) {
                    return Flexible(
                        child: FractionallySizedBox(
                            widthFactor: 0.6,
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(ConstantColors.mainBgColor),
                                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))))),
                                onPressed: () async {
                                  if (formKey.currentState!.validate() && snapshot.hasData) {
                                    var t = bloc.getData() as Register;
                                    var response = await AuthApi().registerUser(t);
                                    if (response == 200) {
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(ScaffoldMessengers().error);
                                    }
                                  }
                                },
                                child: const Text('Зарегистрироваться'))));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
