import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/features/shipping/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:nike/service_locator.dart';

class ReceiptScreen extends StatelessWidget {
  final int orderId;
  const ReceiptScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('رسید پرداخت'),
      ),
      body: BlocProvider<CheckoutBloc>(
        create: (context) => sl<CheckoutBloc>()..add(CheckoutStarted(orderId)),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutError) {
              return Center(
                child: Text(state.error.message),
              );
            }
            if (state is CheckoutLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is CheckoutLoaded) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          state.checkout.purchaseSuccess! ? 'پرداخت با موفقیت انجام شد' : 'پرداخت ناموفق',
                          style: theme.textTheme.titleLarge!.apply(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'وضعیت سفارش',
                              style: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            ),
                            Text(
                              state.checkout.paymentStatus!,
                              style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 32,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'مبلغ',
                              style: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            ),
                            Text(
                              state.checkout.payablePrice!.withPriceLabel,
                              style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                        );
                      },
                      child: const Text('بازگشت به صفحه اصلی'))
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
