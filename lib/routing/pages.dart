import 'package:eCommerce/features/authentication/presentation/views/profile_screen.dart';
import 'package:eCommerce/features/authentication/presentation/views/signin_screen.dart';
import 'package:eCommerce/screens/classfierButton.dart';
import 'package:eCommerce/screens/orderConfirmation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../features/cart/presentation/cart_screen.dart';
import '../features/catalog/catalog_screen.dart';
import '../features/checkout/presentation/checkout_screen.dart';
import '../features/payment/presentation/payment_screen.dart';
import '../features/products/domain/productModel.dart';
import '../features/products/presentation/product_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/wishList/presentation/wishlist_screen.dart';
import '../screens/home_screen.dart';
import '../features/category/domain/category_model.dart' as MyAppCategory;

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/SignIn':
        return SignInView.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case CatalogScreen.routeName:
        return CatalogScreen.route(
            category: settings.arguments as MyAppCategory.Category);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case ClassfierButton.routeName:
        return ClassfierButton.route();
      case OrderConfirmation.routeName:
        return OrderConfirmation.route();
      case PaymentSelection.routeName:
        return PaymentSelection.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
