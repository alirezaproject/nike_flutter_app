import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/feature_banner/domain/entities/banner_entity.dart';
import 'package:nike/features/feature_banner/domain/use_cases/get_banner_usecase.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';
import 'package:nike/features/feature_product/domain/use_cases/get_product_list_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBannerUseCase _getBannerUseCase;
  final GetProductListUseCase _getProductListUseCase;
  HomeBloc(this._getBannerUseCase, this._getProductListUseCase) : super(HomeStarted()) {
    on<HomeEvent>((event, emit) async {
      if (event is LoadHomeEvent || event is RefreshHomeEvent) {
        try {
          emit(HomeLoading());
          final banners = await _getBannerUseCase();
          final latestProducts = await _getProductListUseCase(ProductSort.latest);
          final popularProducts = await _getProductListUseCase(ProductSort.popular);

          emit(HomeCompleted(
            banners: banners.data!,
            latestProducts: latestProducts.data!,
            popularProducts: popularProducts.data!,
          ));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
