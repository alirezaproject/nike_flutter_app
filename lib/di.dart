import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:nike/features/feature_product/data/data_source/remote/banner_api_service.dart';
import 'package:nike/features/feature_product/data/repos/banner_repo_impl.dart';
import 'package:nike/features/feature_product/domain/repos/banner_repo.dart';

final di = GetIt.instance;

Future<void> initializeDependencies() async {
  di.registerSingleton<Dio>(Dio());

  // Api Service
  di.registerSingleton<BannerApiService>(di());

  // Repositories
  di.registerSingleton<BannerRepo>(BannerRepoImpl(di()));

  // UseCases
}
