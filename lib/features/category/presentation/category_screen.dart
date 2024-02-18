import 'package:carousel_slider/carousel_slider.dart';
import 'package:eCommerce/features/category/application/bloc/category_bloc.dart';
import 'package:eCommerce/reusable_widgets/carousel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Column(children: [
      BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            context.read<CategoryBloc>().add(LoadCategories());
            // Future.delayed(Duration(seconds: 5), () {

            // });
            if (kDebugMode) {
              print('Loading Product state received');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // if (state is ClassifyImageResult) {
          //   if (kDebugMode) {
          //     print("Load category successful");
          //   }
          //   final category = state.props;
          //   print('Category count: ${category.length}');
          //   return CarouselSlider(
          //     options: CarouselOptions(
          //       aspectRatio: 1.5,
          //       viewportFraction: 0.9,
          //       enlargeCenterPage: true,
          //       enlargeStrategy: CenterPageEnlargeStrategy.height,
          //     ),
          //     items: category
          //         .map((category) => HeroCarouselCard(category: ))
          //         .toList(),
          //   );
          // }
          else {
            return Text('Something went wrong.');
          }
        },
      ),
    ]);
    return Text('error');
  }
}
