import 'package:eCommerce/features/wishList/application/wishlist_repository.dart';
import 'package:hive/hive.dart';

import '../../products/domain/productModel.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = 'wishlist_products';
  Type boxType = Product;

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Product>(boxName);
    return box;
  }

  @override
  List<Product> getWishlist(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<void> addProductToWishlist(Box box, Product product) async {
    await box.put(product, product);
  }

  @override
  Future<void> removeProductFromWishlist(Box box, Product product) async {
    await box.delete(product);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}
