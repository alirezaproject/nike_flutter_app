import 'package:flutter/material.dart';
import 'package:nike/core/utils/constants.dart';

class NikeAppBar extends StatelessWidget {
  const NikeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      child: Image.asset(
        '${Constants.baseImageLocation}nike_logo.png',
        fit: BoxFit.fitHeight,
        height: 28,
      ),
    );
  }
}
