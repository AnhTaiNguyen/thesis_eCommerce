import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/category/application/bloc/category_bloc.dart';
import '../features/products/application/blocs/bloc/product_bloc.dart';

import '../reusable_widgets/carousel.dart';
import '../reusable_widgets/customAppBar.dart';

import '../reusable_widgets/navBar.dart';
import '../reusable_widgets/product_carousel.dart';

import '../reusable_widgets/sectionTitle.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'AnhTai Demo',
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: const CustomNavBar(screen: routeName),
        body: Container(
          color: Color.fromRGBO(245, 226, 183, 1),
          child: Column(
            children: [
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
                  if (state is CategoryLoaded) {
                    if (kDebugMode) {
                      print("Load category successful");
                    }
                    final category = state.categories;
                    print('Category count: ${category.length}');
                    return CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.5,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                      ),
                      items: category
                          .map((category) =>
                              HeroCarouselCard(category: category))
                          .toList(),
                    );
                  } else {
                    return Text('Something went wrong.');
                  }
                },
              ),
              const SectionTitle(title: 'RECOMMENDED'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    context.read<ProductBloc>().add(LoadProducts());
                    // Future.delayed(Duration(seconds: 5), () {

                    // });
                    if (kDebugMode) {
                      print('Loading Product state received');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProductLoaded) {
                    final product = state.products;
                    print(product[0]);
                    return ProductCarousel(
                      products: state.products
                          .where((product) => product.isPopular)
                          .toList(),
                    );
                  } else {
                    return const Text('Something went wrong.');
                  }
                },
              ),
              const SectionTitle(title: 'MOST POPULAR'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    // Simulate a 5-second delay
                    Future.delayed(const Duration(seconds: 5), () {
                      context.read<ProductBloc>().add(LoadProducts());
                    });

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductLoaded) {
                    final product = state.products;
                    print(product[0]);
                    return ProductCarousel(
                      products: state.products
                          .where((product) => product.isRecommended)
                          .toList(),
                    );
                    // GridView.builder(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 8.0,
                    //     vertical: 16.0,
                    //   ),
                    //   scrollDirection: Axis.horizontal,
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     childAspectRatio: 1.15,
                    //   ),
                    //   itemCount: product.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ProductCarousel(
                    //         products: state.products
                    //             .where((product) => product.isRecommended)
                    //             .toList());
                    //   },
                    // );
                  } else {
                    return const Text('Something went wrong.');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
