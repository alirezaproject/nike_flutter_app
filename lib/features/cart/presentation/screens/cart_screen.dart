import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/widgets/empty_state.dart';
import 'package:nike/features/auth/data/repository/auth_repository.dart';
import 'package:nike/features/auth/presentation/screens/auth_screen.dart';
import 'package:nike/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:nike/features/cart/presentation/widgets/cart_item.dart';
import 'package:nike/features/cart/presentation/widgets/price_info.dart';
import 'package:nike/service_locator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool stateIsSuccess = false;
  late final CartBloc cartBloc;
  final RefreshController _refreshController = RefreshController();
  StreamSubscription? streamSubscription;
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

    streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('سبد خرید'),
      ),
      floatingActionButton: Visibility(
        visible: stateIsSuccess,
        child: Container(
          margin: const EdgeInsets.only(left: 48, right: 48),
          width: double.infinity,
          child: FloatingActionButton.extended(
            foregroundColor: Colors.white,
            onPressed: () {},
            label: const Text('پرداخت'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocProvider(
        create: (context) {
          final bloc = sl<CartBloc>();
          streamSubscription = bloc.stream.listen((state) {
            setState(() {
              stateIsSuccess = state is CartSuccess;
            });

            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              } else if (state is CartError) {
                _refreshController.refreshFailed();
              }
            }
          });
          cartBloc = bloc;
          bloc.add(LoadCart(authModel: AuthRepository.authChangeNotifier.value));

          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is CartSuccess) {
              return SmartRefresher(
                onRefresh: () {
                  cartBloc.add(
                    LoadCart(authModel: AuthRepository.authChangeNotifier.value, isRefresh: true),
                  );
                },
                controller: _refreshController,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: state.cart.cartItems!.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.cart.cartItems!.length) {
                      final cart = state.cart.cartItems![index];
                      return CartItemWidget(
                        theme: theme,
                        cart: cart,
                        onDeleteButtonClick: () {
                          cartBloc.add(ClickDeleteCartEvent(cartItemId: cart.cartItemId!));
                        },
                        onDecreaseButtonClick: () {
                          if (cart.count! > 1) {
                            cartBloc.add(ClickDecreaseCountButton(cartItemId: cart.cartItemId!));
                          }
                        },
                        onIncreaseButtonClick: () => cartBloc.add(ClickIncreaseCountButton(cartItemId: cart.cartItemId!)),
                      );
                    } else {
                      return PriceInfo(
                        payablePrice: state.cart.payablePrice!,
                        shippingCost: state.cart.shippingCost!,
                        totalPrice: state.cart.totalPrice!,
                      );
                    }
                  },
                ),
              );
            } else if (state is CartAuthRequired) {
              return EmptyView(
                message: 'برای مشاهده سبد خرید ابتدا وارد حساب خود شوید',
                callToAction: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  child: const Text('ورود به حساب کاربری'),
                ),
                image: SvgPicture.asset(
                  '${Constants.baseImageLocation}auth_required.svg',
                  width: 140,
                ),
              );
            } else if (state is CartEmptyState) {
              return SmartRefresher(
                controller: _refreshController,
                child: EmptyView(
                  message: 'سبد خرید شما خالی می باشد',
                  image: SvgPicture.asset(
                    "${Constants.baseImageLocation}empty_cart.svg",
                    width: 200,
                  ),
                ),
              );
            }
            return const SizedBox();
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