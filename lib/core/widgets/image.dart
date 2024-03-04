import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoadImage extends StatelessWidget {
  final String image;
  const LoadImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: Colors.black,
      imageUrl: 'assets/images/$image',
    );
  }
}
