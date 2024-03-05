import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nike/core/resources/data_state.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/features/feature_product/data/data_source/remote/banner_api_service.dart';
import 'package:nike/features/feature_product/data/models/banner_model/banner_model.dart';
import 'package:nike/features/feature_product/domain/repos/banner_repo.dart';

class BannerRepoImpl implements BannerRepo {
  final BannerApiService bannerApiService;

  BannerRepoImpl(this.bannerApiService);

  @override
  Future<DataState<List<BannerModel>>> fetchBannerListData() async {
    try {
      Response response = await bannerApiService.callBannerList();
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(Constants.defaultErrorMessage);
      }
    } catch (e) {
      return DataFailed(Constants.defaultErrorMessage);
    }
  }
}
