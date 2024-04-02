import 'dart:async';

import 'package:nike/core/resources/data_state.dart';
import 'package:nike/features/banner/domain/entities/banner_entity.dart';

abstract class IBannerRepository {
  Future<DataState<List<BannerEntity>>> fetchBannerListData();
}
