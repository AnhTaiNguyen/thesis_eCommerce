import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final List<String> imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;
  final String description;

  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
    required this.description,
  });

  static Product fromDocumentSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // ignore: unnecessary_null_comparison
    if (data != null) {
      final dynamic imageUrlData = data['imageUrl'];
      List<String> imageUrlList = [];
      if (imageUrlData is List) {
        imageUrlList = imageUrlData.map((e) => e.toString()).toList();
      } else {
        print('Warning: imageUrlData is not a List');
      }

      return Product(
        name: data['name'] as String,
        category: data['category'] as String,
        imageUrl: imageUrlList,
        price: (data['price'] as num?)?.toDouble() ?? 0.0,
        isRecommended: data['isRecommended'] as bool,
        isPopular: data['isPopular'] as bool,
        description: data['description'] as String? ?? 'Unknown',
      );
    } else {
      // Handle the case where data is null (e.g., document doesn't exist).
      return const Product(
          name: 'Unknown',
          category: 'Unknown',
          imageUrl: [],
          price: 0.0,
          isRecommended: false,
          isPopular: false,
          description: 'Unknown');
    }
  }

  @override
  List<Object?> get props => [
        name,
        category,
        imageUrl,
        price,
        isRecommended,
        isPopular,
        description,
      ];
}
