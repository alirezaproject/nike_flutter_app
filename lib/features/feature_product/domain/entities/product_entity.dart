import 'package:equatable/equatable.dart';

class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowtoHigh = 3;
}

class ProductEntity extends Equatable {
  final int? id;
  final String? title;
  final int? price;
  final int? discount;
  final String? image;
  final int? status;
  final int? previousPrice;

  const ProductEntity(
      {required this.id,
      required this.title,
      required this.price,
      required this.discount,
      required this.image,
      required this.status,
      required this.previousPrice});

  @override
  List<Object?> get props => [];
}
