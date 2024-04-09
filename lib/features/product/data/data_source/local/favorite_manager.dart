import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class FavoriteManager {
  static const _boxName = 'favorites';

  final _box = Hive.box<ProductEntity>(_boxName);

  static ValueListenable<Box<ProductEntity>> get listenable => Hive.box<ProductEntity>(_boxName).listenable();

  static init() async {
    var appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    var customPath = '${appDocumentDirectory.path}/hive_data';
    Hive.init(customPath);
    Hive.registerAdapter(ProductEntityAdapter());
    await Hive.openBox<ProductEntity>(_boxName);
  }

  void addFavorite(ProductEntity product) {
    _box.put(product.id, product);
  }

  void delete(ProductEntity product) {
    _box.delete(product.id);
  }

  List<ProductEntity> get favorites => _box.values.toList();

  bool isFavorite(ProductEntity product) {
    return _box.containsKey(product.id);
  }
}
