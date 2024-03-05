import 'dart:async';

import 'package:nike/core/resources/data_state.dart';
import 'package:nike/features/feature_product/domain/entities/banner_entity.dart';

abstract class BannerRepo {
  Future<DataState<List<BannerEntity>>> fetchBannerListData();
}
