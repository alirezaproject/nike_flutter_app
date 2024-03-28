import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/core/widgets/image.dart';
import 'package:nike/features/feature_auth/data/repository/auth_repository.dart';
import 'package:nike/features/feature_auth/presentation/screens/auth_screen.dart';
import 'package:nike/features/feature_cart/presentation/bloc/cart_bloc.dart';
import 'package:nike/service_locator.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final CartBloc cartBloc;
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc.add(CartAuthInfoChanged(authModel: AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier.removeListener(authChangeNotifierListener);
    cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('سبد خرید'),
      ),
      body: BlocProvider(
        create: (context) {
          final bloc = CartBloc(sl());
          cartBloc = bloc;
          bloc.add(LoadCart(authModel: AuthRepository.authChangeNotifier.value));

          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is CartSuccess) {
              return ListView.builder(
                itemCount: state.cart.cartItems!.length,
                itemBuilder: (BuildContext context, int index) {
                  final cart = state.cart.cartItems![index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: LoadImage(
                                  image: cart.product!.image!,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    cart.product!.title!,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('تعداد'),
                                  Row(
                                    children: [
                                      IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.plus_rectangle)),
                                      Text(cart.count!.toString(), style: theme.textTheme.titleLarge),
                                      IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.minus_rectangle)),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    cart.product!.previousPrice!.withPriceLabel(),
                                    style: TextStyle(decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    cart.product!.price!.withPriceLabel(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('حذف از سبد خرید'),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is CartAuthRequired) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('وارد حساب کاربری خود شوید'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AuthScreen(),
                              ),
                            );
                          },
                          child: Text('ورود'))
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

//    ValueListenableBuilder<AuthModel?>(
      //     valueListenable: AuthRepository.authChangeNotifier,
      //     builder: (BuildContext context, authState, Widget? child) {
      //       bool isAuthenticated = authState != null && authState.accessToken.isNotEmpty;
      //       return Center(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               isAuthenticated ? 'خوش آمدید' : 'لطفا وارد حساب کاربری خود شوید',
      //             ),
      //              !isAuthenticated
      //                 ? ElevatedButton(
      //                     onPressed: () {
      //                       Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      //                         builder: (context) => AuthScreen(),
      //                       ));
      //                     },
      //                     child: Text('ورود'),
      //                   )
      //                 : ElevatedButton(
      //                     onPressed: () {
      //                       _signOutUserUseCase();
      //                     },
      //                     child: Text('خروج از حساب'),
      //                   ),
      //             ElevatedButton(
      //               onPressed: () {
      //                 _signOutUserUseCase.refreshToken();
      //               },
      //               child: Text('Refresh Token'),
      //             )
      //           ],
      //         ),
      //       );
      //     },
      //   ),