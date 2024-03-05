import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';

@immutable
class ProductModel extends ProductEntity {
  final int? id;
  final String? title;
  final int? price;
  final int? discount;
  final String? image;
  final int? status;
  final int? previousPrice;

  ProductModel({
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

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        title: data['title'] as String?,
        price: data['price'] as int?,
        discount: data['discount'] as int?,
        image: data['image'] as String?,
        status: data['status'] as int?,
        previousPrice: data['previous_price'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'discount': discount,
        'image': image,
        'status': status,
        'previous_price': previousPrice,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
