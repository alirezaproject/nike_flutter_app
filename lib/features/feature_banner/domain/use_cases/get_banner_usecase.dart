import 'package:nike/core/resources/data_state.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/feature_banner/domain/entities/banner_entity.dart';
import 'package:nike/features/feature_banner/domain/repository/banner_repository.dart';

class GetBannerUseCase
    extends UseCase<DataState<List<BannerEntity>>, NoParams> {
  final IBannerRepository bannerRepo;

  GetBannerUseCase(this.bannerRepo);

  @override
  Future<DataState<List<BannerEntity>>> call(NoParams params) {
    return bannerRepo.fetchBannerListData();
  }
}
