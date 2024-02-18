import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eCommerce/features/products/domain/productModel.dart';
import 'package:equatable/equatable.dart';
import '../../domain/category_model.dart';
import '../category_services.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
    // on<ClassifyImageResult>(_onUpdateCategoryLabel); // Add this line
  }

  void _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllCategories().listen(
          (products) => add(
            UpdateCategories(products),
          ),
        );
  }

  void _onUpdateCategories(
    UpdateCategories event,
    Emitter<CategoryState> emit,
  ) {
    emit(
      CategoryLoaded(categories: event.categories),
    );
  }

  // void _onUpdateCategoryLabel(
  //   ClassifyImageResult event,
  //   Emitter<CategoryState> emit,
  // ) {
  //   emit(
  //     CategoryLabelLoaded(categoryLabel: event.),
  //   );
  // }
}
