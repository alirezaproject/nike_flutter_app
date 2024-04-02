import 'package:nike/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final int? id;
  final String? title;
  final int? price;
  final int? discount;
  final String? image;
  final int? status;
  final int? previousPrice;

  const ProductModel({
    this.id,
    this.title,
    this.price,
    this.discount,
    this.image,
    this.status,
    this.previousPrice,
  }) : super(
          id: id,
          title: title,
          price: price,
          discount: discount,
          image: image,
          status: status,
          previousPrice: previousPrice,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        price: json['price'] as int?,
        discount: json['discount'] as int?,
        image: json['image'] as String?,
        status: json['status'] as int?,
        previousPrice: json['previous_price'] as int? ?? json['price'] + json['discount'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'discount': discount,
        'image': image,
        'status': status,
        'previous_price': previousPrice,
      };
}
