import 'package:flutter/material.dart';
import 'package:nike/core/params/auth_params.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/di.dart';
import 'package:nike/features/feature_auth/domain/repository/auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final IAuthRepository _authRepository = di<IAuthRepository>();
  bool isLogin = true;

  TextEditingController usernameController = TextEditingController(text: 'test@gmail.com');
  TextEditingController passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color onBackground = Colors.white;
    return Theme(
      data: theme.copyWith(
        textTheme: TextTheme(titleMedium: theme.textTheme.titleMedium!.copyWith(color: onBackground)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 18)),
            minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(56)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            backgroundColor: MaterialStateProperty.all<Color>(onBackground),
            foregroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.secondary),
          ),
        ),
        colorScheme: theme.colorScheme.copyWith(
          primary: onBackground,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: onBackground,
          focusColor: onBackground,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: onBackground),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          labelStyle: TextStyle(color: onBackground),
        ),
      ),
      child: Scaffold(
        backgroundColor: theme.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                '${Constants.baseImageLocation}nike_logo.png',
                color: onBackground,
                width: 120,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                isLogin ? 'خوش آمدید' : 'ثبت نام',
                style: TextStyle(color: onBackground, fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                isLogin ? 'لطفا وارد حساب کاربری خود شوید' : 'ایمیل و رمز عبور خود را تعیین کنید',
                style: TextStyle(color: onBackground, fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text('آدرس ایمیل'),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              _PasswordTextField(
                onBackground: onBackground,
                controller: passwordController,
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  _authRepository.login(
                    AuthParams(username: usernameController.text, password: passwordController.text),
                  );
                },
                child: Text(isLogin ? 'ورود' : 'ثبت نام'),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin ? 'حساب کاربری ندارید ؟' : 'حساب کاربری دارید ؟',
                    style: TextStyle(color: onBackground),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? 'ثبت نام' : 'ورود',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.onBackground,
    required this.controller,
  });

  final Color onBackground;
  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool isSecure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isSecure,
      decoration: InputDecoration(
        label: Text('رمز عبور'),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isSecure = !isSecure;
            });
          },
          icon: Icon(
            isSecure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: widget.onBackground,
          ),
        ),
      ),
    );
  }
}
