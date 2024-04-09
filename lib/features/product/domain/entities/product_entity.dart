import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final int? price;
  @HiveField(3)
  final int? discount;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final int? status;
  @HiveField(6)
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

class ProductSort {
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowtoHigh = 3;

  static const List<String> names = [
    'جدیدترین',
    'پربازدیدترین',
    'قیمت نزولی',
    'قیمت صعودی',
  ];
}
