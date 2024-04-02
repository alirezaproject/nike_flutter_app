class BannerModel {
  int? id;
  String? image;
  int? linkType;
  String? linkValue;

  BannerModel({this.id, this.image, this.linkType, this.linkValue});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'] as int?,
        image: json['image'] as String?,
        linkType: json['link_type'] as int?,
        linkValue: json['link_value'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'link_type': linkType,
        'link_value': linkValue,
      };
}
