import 'package:flutter/material.dart';
import 'package:nike/core/utils/error_handler.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onTap;
  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.message),
          ElevatedButton(
            onPressed: onTap,
            child: const Text('تلاش مجدد'),
          ),
        ],
      ),
    );
  }
}
