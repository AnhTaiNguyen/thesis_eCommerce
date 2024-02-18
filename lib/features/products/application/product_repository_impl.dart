import '../domain/productModel.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
