import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/features/cart/presentation/widgets/price_info.dart';
import 'package:nike/features/shipping/presentation/bloc/shipping_bloc.dart';
import 'package:nike/features/shipping/presentation/screen/payment_webview.dart';
import 'package:nike/features/shipping/presentation/screen/receipt.dart';
import 'package:nike/service_locator.dart';

class ShippingScreen extends StatefulWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;
  const ShippingScreen({super.key, required this.payablePrice, required this.shippingCost, required this.totalPrice});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController = TextEditingController(text: 'علیرضا');

  final TextEditingController lastNameController = TextEditingController(text: 'شکوهیان');

  final TextEditingController phoneNumberController = TextEditingController(text: '09172638641');

  final TextEditingController postalCodeController = TextEditingController(text: '7417774333');

  final TextEditingController addressController = TextEditingController(text: 'خیابان جانبازان کوچه 1000');

  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحویل گیرنده'),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = sl<ShippingBloc>();
          subscription = bloc.stream.listen((state) {
            if (state is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.message)));
            } else if (state is ShippingLoaded) {
              if (state.result.bankGatewayUrl!.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentGatewayScreen(
                        bankGatewayUrl: state.result.bankGatewayUrl!,
                      ),
                    ));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReceiptScreen(
                          orderId: state.result.orderId!,
                        )));
              }
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    label: Text('نام'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    label: Text('نام خانوادگی'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: postalCodeController,
                  decoration: const InputDecoration(
                    label: Text('کد پستی'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    label: Text('شماره تماس'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    label: Text('آدرس تحویل گیرنده'),
                  ),
                ),
                PriceInfo(payablePrice: widget.payablePrice, shippingCost: widget.shippingCost, totalPrice: widget.totalPrice),
                BlocBuilder<ShippingBloc, ShippingState>(
                  builder: (context, state) {
                    if (state is ShippingLoading) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                  ShippingCreateOrder(
                                    CreateOrderParams(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        phoneNumber: phoneNumberController.text,
                                        postalCode: postalCodeController.text,
                                        address: addressController.text,
                                        paymenyMethod: PaymentMethod.cashOnDelivery),
                                  ),
                                );
                              },
                              child: const Text('پرداخت در محل')),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ShippingBloc>(context).add(
                                  ShippingCreateOrder(
                                    CreateOrderParams(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        phoneNumber: phoneNumberController.text,
                                        postalCode: postalCodeController.text,
                                        address: addressController.text,
                                        paymenyMethod: PaymentMethod.online),
                                  ),
                                );
                              },
                              child: const Text('پرداخت اینترنتی')),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
