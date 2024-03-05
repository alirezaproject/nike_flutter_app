import 'package:nike/core/resources/data_state.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/feature_product/domain/entities/banner_entity.dart';
import 'package:nike/features/feature_product/domain/repos/banner_repo.dart';

class GetBannerUseCase extends UseCase<DataState<List<BannerEntity>>, void> {
  final BannerRepo bannerRepo;

  GetBannerUseCase(this.bannerRepo);
  @override
  Future<DataState<List<BannerEntity>>> call(void params) {
    return bannerRepo.fetchBannerListData();
  }
}
