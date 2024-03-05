import 'dart:convert';

import 'package:nike/features/feature_product/domain/entities/banner_entity.dart';

class BannerModel extends BannerEntity {
  final int? id;
  final String? image;

  BannerModel({
    this.id,
    this.image,
  }) : super(id: id, image: image);

  factory BannerModel.fromMap(Map<String, dynamic> data) => BannerModel(
        id: data['id'] as int?,
        image: data['image'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BannerModel].
  factory BannerModel.fromJson(String data) {
    return BannerModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BannerModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
