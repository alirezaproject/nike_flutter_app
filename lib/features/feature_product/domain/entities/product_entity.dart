class ProductEntity {
  final int? id;
  final String? title;
  final int? price;
  final int? discount;
  final String? image;
  final int? status;
  final int? previousPrice;

  ProductEntity(
      {required this.id,
      required this.title,
      required this.price,
      required this.discount,
      required this.image,
      required this.status,
      required this.previousPrice});
}
