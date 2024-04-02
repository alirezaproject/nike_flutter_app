import 'package:flutter/material.dart';
import 'package:nike/features/banner/domain/entities/banner_entity.dart';

@immutable
abstract class BannerStatus {}

class BannerLoading extends BannerStatus {}

class BannerCompleted extends BannerStatus {
  final List<BannerEntity> banners;

  BannerCompleted({required this.banners});
}

class BannerError extends BannerStatus {
  final String errorMessage;

  BannerError(this.errorMessage);
}
