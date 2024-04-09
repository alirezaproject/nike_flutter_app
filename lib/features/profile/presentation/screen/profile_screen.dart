import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/features/auth/data/models/auth_model.dart';
import 'package:nike/features/auth/data/repository/auth_repository.dart';
import 'package:nike/features/auth/domain/usecases/signout_user_usecase.dart';
import 'package:nike/features/auth/presentation/screens/auth_screen.dart';
import 'package:nike/features/cart/data/repos/cart_repository.dart';
import 'package:nike/features/profile/presentation/screen/favorite_screen.dart';
import 'package:nike/service_locator.dart';

class ProfileScreen extends StatelessWidget {
  final SignOutUserUseCase _signOutUserUseCase = sl();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('پروفایل'),
      ),
      body: ValueListenableBuilder<AuthModel?>(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, value, child) {
          final isLogin = value != null && value.accessToken.isNotEmpty;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 32),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Theme.of(context).dividerColor, width: 1),
                  ),
                  child: Image.asset('assets/images/nike_logo.png'),
                ),
                Text(isLogin ? value.email : 'کاربر میهمان'),
                const SizedBox(
                  height: 32,
                ),
                Divider(
                  height: 1,
                  color: Colors.black.withOpacity(0.5),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteScreen()));
                  },
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.heart),
                        SizedBox(
                          width: 16,
                        ),
                        Text('لیست علاقه مندی ها'),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                InkWell(
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ));
                  },
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.cart),
                        SizedBox(
                          width: 16,
                        ),
                        Text('سوابق سفارش'),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                InkWell(
                  onTap: () {
                    if (isLogin) {
                      showDialog(
                        context: context,
                        useRootNavigator: true,
                        builder: (context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              title: const Text('خروج از حساب کاربری'),
                              content: const Text('آیا میخواهید از حساب خود خارج شوید ؟'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('خیر')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      CartRepository.cartItemCountNotifier.value = 0;
                                      _signOutUserUseCase();
                                    },
                                    child: const Text('بله')),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => const AuthScreen()));
                    }
                  },
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Row(
                      children: [
                        Icon(
                          isLogin ? CupertinoIcons.arrow_right_square : CupertinoIcons.arrow_left_square,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(isLogin ? 'خروج از حساب کاربری' : "ورود به حساب کاربری"),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
