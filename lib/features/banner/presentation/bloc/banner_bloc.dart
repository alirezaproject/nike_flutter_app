import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/resources/data_state.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/domain/use_cases/get_product_list_usecase.dart';
import 'package:nike/features/banner/presentation/bloc/status/banner_status.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetProductListUseCase getProductListUseCase;
  BannerBloc(this.getProductListUseCase)
      : super(BannerState(bannerStatus: BannerLoading())) {
    on<LoadBannersEvent>((event, emit) async {
      emit(state.copyWith(BannerLoading()));

      DataState data = await getProductListUseCase(ProductSort.latest);

      if (data is DataSuccess) {
        emit(state.copyWith(BannerCompleted(banners: data.data)));
      }
      if (data is DataFailed) {
        emit(state.copyWith(BannerError(data.error!)));
      }
    });
  }
}
