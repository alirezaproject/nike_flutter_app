import 'package:dio/dio.dart';
import 'package:nike/core/resources/data_state.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/feature_banner/data/data_source/remote/banner_api_service.dart';
import 'package:nike/features/feature_banner/data/model/banner_model/banner_model.dart';
import 'package:nike/features/feature_banner/domain/entities/banner_entity.dart';
import 'package:nike/features/feature_banner/domain/repository/banner_repository.dart';

class BannerRepository with HttpValidator implements IBannerRepository {
  final BannerApiService bannerApiService;

  BannerRepository(this.bannerApiService);

  @override
  Future<DataState<List<BannerEntity>>> fetchBannerListData() async {
    try {
      Response response = await bannerApiService.getBannersList();
      validateResponse(response);

      List<BannerEntity> bannerEntity = (response.data as List)
          .map((json) => BannerModel.fromJson(json))
          .map((e) => BannerEntity(
                id: e.id,
                image: e.image,
              ))
          .toList();

      return DataSuccess(bannerEntity);
    } catch (e) {
      return DataFailed(Constants.defaultErrorMessage);
    }
  }
}
