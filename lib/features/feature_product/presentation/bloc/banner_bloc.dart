import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/resources/data_state.dart';
import 'package:nike/features/feature_product/domain/use_case/get_banner_usecase.dart';
import 'package:nike/features/feature_product/presentation/bloc/status/banner_status.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannerUseCase bannerUseCase;
  BannerBloc(this.bannerUseCase) : super(BannerState(bannerStatus: BannerLoading())) {
    on<LoadBannersEvent>((event, emit) async {
      emit(state.copyWith(BannerLoading()));

      DataState data = await bannerUseCase('');

      if (data is DataSuccess) {
        emit(state.copyWith(BannerCompleted(banners: data.data)));
      }
      if (data is DataFailed) {
        emit(state.copyWith(BannerError(data.error!)));
      }
    });
  }
}
