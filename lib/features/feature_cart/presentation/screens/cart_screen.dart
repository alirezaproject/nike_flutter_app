import 'package:flutter/material.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/service_locator.dart';
import 'package:nike/features/feature_auth/data/models/auth_model.dart';
import 'package:nike/features/feature_auth/data/repository/auth_repository.dart';
import 'package:nike/features/feature_auth/domain/usecases/signout_user_usecase.dart';
import 'package:nike/features/feature_auth/presentation/screens/auth_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final SignOutUserUseCase _signOutUserUseCase = sl();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('سبد خرید'),
      ),
      body: ValueListenableBuilder<AuthModel?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (BuildContext context, authState, Widget? child) {
          bool isAuthenticated = authState != null && authState.accessToken.isNotEmpty;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isAuthenticated ? 'خوش آمدید' : 'لطفا وارد حساب کاربری خود شوید',
                ),
                !isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                            builder: (context) => AuthScreen(),
                          ));
                        },
                        child: Text('ورود'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _signOutUserUseCase();
                        },
                        child: Text('خروج از حساب'),
                      ),
                ElevatedButton(
                  onPressed: () {
                    _signOutUserUseCase.refreshToken();
                  },
                  child: Text('Refresh Token'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
