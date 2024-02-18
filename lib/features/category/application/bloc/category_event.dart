part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class ClassifyImageResult extends CategoryEvent {
  // final String categoryLabel;
  final Category category;

  const ClassifyImageResult({required this.category});

  @override
  List<Category> get props => [category];
}

class LoadCategories extends CategoryEvent {}

class UpdateCategories extends CategoryEvent {
  final List<Category> categories;

  UpdateCategories(this.categories);

  @override
  List<Object> get props => [categories];
}
