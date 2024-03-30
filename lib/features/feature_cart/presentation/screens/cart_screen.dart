import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/widgets/empty_state.dart';
import 'package:nike/features/feature_auth/data/repository/auth_repository.dart';
import 'package:nike/features/feature_auth/presentation/screens/auth_screen.dart';
import 'package:nike/features/feature_cart/presentation/bloc/cart_bloc.dart';
import 'package:nike/features/feature_cart/presentation/widgets/cart_item.dart';
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
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        centerTitle: true,
        title: Text('سبد خرید'),
      ),
      body: BlocProvider(
        create: (context) {
          final bloc = CartBloc(sl(), sl());
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
                  return CartItemWidget(
                    theme: theme,
                    cart: cart,
                    onDeleteButtonClick: () {
                      cartBloc.add(ClickDeleteCartEvent(cartItemId: cart.cartItemId!));
                    },
                  );
                },
              );
            } else if (state is CartAuthRequired) {
              return EmptyView(
                message: 'برای مشاهده سبد خرید ابتدا وارد حساب خود شوید',
                callToAction: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AuthScreen(),
                      ),
                    );
                  },
                  child: Text('ورود به حساب کاربری'),
                ),
                image: SvgPicture.asset(
                  '${Constants.baseImageLocation}auth_required.svg',
                  width: 140,
                ),
              );
            } else if (state is CartEmptyState) {
              return EmptyView(
                message: 'سبد خرید شما خالی می باشد',
                image: SvgPicture.asset(
                  "${Constants.baseImageLocation}empty_cart.svg",
                  width: 200,
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