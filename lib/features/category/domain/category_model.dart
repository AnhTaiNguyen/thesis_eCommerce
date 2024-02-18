import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({
    required this.name,
    required this.imageUrl,
  });

  static Category fromDocumentSnapshot(DocumentSnapshot document) {
    final categoryData = document.data() as Map<String, dynamic>;

    if (categoryData.isNotEmpty) {
      print(categoryData);
      return Category(
          name: categoryData['name'] as String,
          imageUrl: categoryData['imageUrl'] as String);
    } else {
      return const Category(name: 'unknown', imageUrl: 'unknown');
    }
  }

  @override
  List<Object?> get props => [
        name,
        imageUrl,
      ];
}
