import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:nike/features/feature_auth/data/data_source/remote/auth_api_service.dart';
import 'package:nike/features/feature_auth/data/repository/auth_repository.dart';
import 'package:nike/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:nike/features/feature_auth/domain/usecases/login_user_usecase.dart';
import 'package:nike/features/feature_auth/domain/usecases/register_user_usecase.dart';
import 'package:nike/features/feature_auth/domain/usecases/signout_user_usecase.dart';
import 'package:nike/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:nike/features/feature_banner/data/data_source/remote/banner_api_service.dart';
import 'package:nike/features/feature_banner/data/repository/banner_repository.dart';
import 'package:nike/features/feature_banner/domain/repository/banner_repository.dart';
import 'package:nike/features/feature_banner/domain/use_cases/get_banner_usecase.dart';
import 'package:nike/features/feature_cart/data/repos/cart_repository.dart';
import 'package:nike/features/feature_cart/data/source/remote/cart_api_service.dart';
import 'package:nike/features/feature_cart/domain/repos/cart_repository.dart';
import 'package:nike/features/feature_cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:nike/features/feature_cart/domain/usecases/delete_cart_item_usecase.dart';
import 'package:nike/features/feature_cart/domain/usecases/get_cart_list_usecase.dart';
import 'package:nike/features/feature_cart/presentation/bloc/cart_bloc.dart';
import 'package:nike/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:nike/features/feature_product/data/data_source/remote/comment_api_service.dart';
import 'package:nike/features/feature_product/data/data_source/remote/product_api_service.dart';
import 'package:nike/features/feature_product/data/repository/comment_repository.dart';
import 'package:nike/features/feature_product/data/repository/product_repository.dart';
import 'package:nike/features/feature_product/domain/repository/comment_repository.dart';
import 'package:nike/features/feature_product/domain/repository/product_repository.dart';
import 'package:nike/features/feature_product/domain/use_cases/get_comment_list_usecase.dart';
import 'package:nike/features/feature_product/domain/use_cases/get_product_list_usecase.dart';
import 'package:nike/features/feature_product/presentation/bloc/comment/comment_bloc.dart';
import 'package:nike/features/feature_product/presentation/bloc/product/product_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio());

  // Api Service
  sl.registerLazySingleton<ProductApiService>(() => ProductApiService());
  sl.registerLazySingleton<BannerApiService>(() => BannerApiService());
  sl.registerLazySingleton<CommentApiService>(() => CommentApiService());
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService());
  sl.registerLazySingleton<CartApiService>(() => CartApiService());

  // Repositories
  sl.registerLazySingleton<IProductRepository>(() => ProductRepository(sl()));
  sl.registerLazySingleton<IBannerRepository>(() => BannerRepository(sl()));
  sl.registerLazySingleton<ICommentRepository>(() => CommentRepository(sl()));
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<ICartRepository>(() => CartRepository(sl()));

  // UseCases
  sl.registerLazySingleton<GetProductListUseCase>(() => GetProductListUseCase(sl()));
  sl.registerLazySingleton<GetBannerUseCase>(() => GetBannerUseCase(sl()));
  sl.registerLazySingleton<GetCommentListUsecase>(() => GetCommentListUsecase(sl()));
  sl.registerLazySingleton<SignOutUserUseCase>(() => SignOutUserUseCase(sl()));
  sl.registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton<LoginUserUseCase>(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton<AddToCartUseCase>(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton<GetCartListUseCase>(() => GetCartListUseCase(sl()));
  sl.registerLazySingleton<DeleteCartItemUseCase>(() => DeleteCartItemUseCase(sl()));

  // bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl()));
  sl.registerFactory<CommentBloc>(() => CommentBloc(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(true, sl(), sl()));
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl()));
  sl.registerFactory<CartBloc>(() => CartBloc(sl(), sl()));
}
