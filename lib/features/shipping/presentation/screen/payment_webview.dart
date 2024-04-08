import 'package:flutter/material.dart';
import 'package:nike/features/shipping/presentation/screen/receipt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatelessWidget {
  final String bankGatewayUrl;
  const PaymentGatewayScreen({super.key, required this.bankGatewayUrl});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            final uri = Uri.parse(url);
            debugPrint(uri.host);
            debugPrint(uri.pathSegments[0]);
            if (uri.pathSegments.contains('appCheckout') && uri.host == 'expertdevelopers.ir') {
              final orderId = int.parse(uri.queryParameters["order_id"]!);
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReceiptScreen(orderId: orderId),
              ));
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(bankGatewayUrl));

    return WebViewWidget(controller: controller);
  }
}
