import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:nike/features/auth/data/data_source/remote/auth_api_service.dart';
import 'package:nike/features/auth/data/repository/auth_repository.dart';
import 'package:nike/features/auth/domain/repository/auth_repository.dart';
import 'package:nike/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:nike/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:nike/features/auth/domain/usecases/signout_user_usecase.dart';
import 'package:nike/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nike/features/banner/data/data_source/remote/banner_api_service.dart';
import 'package:nike/features/banner/data/repository/banner_repository.dart';
import 'package:nike/features/banner/domain/repository/banner_repository.dart';
import 'package:nike/features/banner/domain/use_cases/get_banner_usecase.dart';
import 'package:nike/features/cart/data/repos/cart_repository.dart';
import 'package:nike/features/cart/data/source/remote/cart_api_service.dart';
import 'package:nike/features/cart/domain/repos/cart_repository.dart';
import 'package:nike/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:nike/features/cart/domain/usecases/cart_change_count_usecase.dart';
import 'package:nike/features/cart/domain/usecases/delete_cart_item_usecase.dart';
import 'package:nike/features/cart/domain/usecases/get_cart_count_item_usecase.dart';
import 'package:nike/features/cart/domain/usecases/get_cart_list_usecase.dart';
import 'package:nike/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:nike/features/home/presentation/bloc/home_bloc.dart';
import 'package:nike/features/product/data/data_source/local/favorite_manager.dart';
import 'package:nike/features/product/data/data_source/remote/comment_api_service.dart';
import 'package:nike/features/product/data/data_source/remote/product_api_service.dart';
import 'package:nike/features/product/data/repository/comment_repository.dart';
import 'package:nike/features/product/data/repository/product_repository.dart';
import 'package:nike/features/product/domain/repository/comment_repository.dart';
import 'package:nike/features/product/domain/repository/product_repository.dart';
import 'package:nike/features/product/domain/use_cases/get_comment_list_usecase.dart';
import 'package:nike/features/product/domain/use_cases/get_product_list_usecase.dart';
import 'package:nike/features/product/presentation/bloc/comment/comment_bloc.dart';
import 'package:nike/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:nike/features/product/presentation/bloc/product_list/product_list_bloc.dart';
import 'package:nike/features/shipping/data/repos/order_repository.dart';
import 'package:nike/features/shipping/data/source/order_api_service.dart';
import 'package:nike/features/shipping/domain/repos/order_repository.dart';
import 'package:nike/features/shipping/domain/usecases/create_order_usecase.dart';
import 'package:nike/features/shipping/domain/usecases/get_checkout_usecase.dart';
import 'package:nike/features/shipping/presentation/bloc/checkout_bloc.dart';
import 'package:nike/features/shipping/presentation/bloc/shipping_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio());

  // Api Service
  sl.registerLazySingleton<ProductApiService>(() => ProductApiService());
  sl.registerLazySingleton<BannerApiService>(() => BannerApiService());
  sl.registerLazySingleton<CommentApiService>(() => CommentApiService());
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService());
  sl.registerLazySingleton<CartApiService>(() => CartApiService());
  sl.registerLazySingleton<OrderApiSerivce>(() => OrderApiSerivce());

  // local services
  sl.registerLazySingleton<FavoriteManager>(() => FavoriteManager());

  // Repositories
  sl.registerLazySingleton<IProductRepository>(() => ProductRepository(sl()));
  sl.registerLazySingleton<IBannerRepository>(() => BannerRepository(sl()));
  sl.registerLazySingleton<ICommentRepository>(() => CommentRepository(sl()));
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<ICartRepository>(() => CartRepository(sl()));
  sl.registerLazySingleton<IOrderRepository>(() => OrderRepository(sl()));

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
  sl.registerLazySingleton<CartChangeCountUseCase>(() => CartChangeCountUseCase(sl()));
  sl.registerLazySingleton<GetCartCountItemUseCase>(() => GetCartCountItemUseCase(sl()));

  sl.registerLazySingleton<CreateOrderUseCase>(() => CreateOrderUseCase(sl()));
  sl.registerLazySingleton<GetCheckoutUseCase>(() => GetCheckoutUseCase(sl()));

  // bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl()));
  sl.registerFactory<CommentBloc>(() => CommentBloc(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(true, sl(), sl(), sl()));
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl(), sl()));
  sl.registerFactory<CartBloc>(() => CartBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<ShippingBloc>(() => ShippingBloc(sl()));
  sl.registerFactory<CheckoutBloc>(() => CheckoutBloc(sl()));
  sl.registerFactory<ProductListBloc>(() => ProductListBloc(sl()));
}
