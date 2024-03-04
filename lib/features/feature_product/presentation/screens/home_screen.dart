import 'package:flutter/material.dart';
import 'package:nike/core/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return SizedBox(height: 35, child: Image.asset('${Constants.defaultImageLocation}nike_logo.png'));
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
