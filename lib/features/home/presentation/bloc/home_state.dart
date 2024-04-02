part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException exception;

  const HomeError({required this.exception});

  @override
  List<Object> get props => [exception];
}

class HomeCompleted extends HomeState {
  final List<BannerEntity> banners;
  final List<ProductEntity> latestProducts;
  final List<ProductEntity> popularProducts;

  const HomeCompleted({
    required this.banners,
    required this.latestProducts,
    required this.popularProducts,
  });

  @override
  List<Object> get props => [banners, latestProducts, popularProducts];
}
