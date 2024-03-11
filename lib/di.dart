import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:nike/features/feature_banner/data/data_source/remote/banner_api_service.dart';
import 'package:nike/features/feature_banner/data/repository/banner_repository.dart';
import 'package:nike/features/feature_banner/domain/repository/banner_repository.dart';
import 'package:nike/features/feature_banner/domain/use_cases/get_banner_usecase.dart';
import 'package:nike/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:nike/features/feature_product/data/data_source/remote/product_api_service.dart';
import 'package:nike/features/feature_product/data/repository/product_repository.dart';
import 'package:nike/features/feature_product/domain/repository/product_repository.dart';
import 'package:nike/features/feature_product/domain/use_cases/get_product_list_usecase.dart';

final di = GetIt.instance;

Future<void> initializeDependencies() async {
  di.registerSingleton<Dio>(Dio());

  // Api Service
  di.registerSingleton<ProductApiService>(ProductApiService());
  di.registerSingleton<BannerApiService>(BannerApiService());

  // Repositories
  di.registerSingleton<IProductRepository>(ProductRepository(di()));
  di.registerSingleton<IBannerRepository>(BannerRepository(di()));

  // UseCases
  di.registerSingleton<GetProductListUseCase>(GetProductListUseCase(di()));
  di.registerSingleton<GetBannerUseCase>(GetBannerUseCase(di()));

  // bloc
  di.registerSingleton<HomeBloc>(HomeBloc(di(), di()));
}
