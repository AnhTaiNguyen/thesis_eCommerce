import 'package:eCommerce/routing/pages.dart';
import 'package:eCommerce/utils/color_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bloc_obsever.dart';
import 'features/authentication/application/authentication_repository.dart';
import 'features/authentication/application/blocs/auth/authentication_bloc_bloc.dart';
import 'features/authentication/data/bloc/database_bloc.dart';
import 'features/authentication/data/database_repository_impl.dart';
import 'features/cart/application/bloc/cart_bloc.dart';
import 'features/category/application/bloc/category_bloc.dart';
import 'features/category/application/category_services.dart';
import 'features/checkout/application/bloc/checkout_bloc.dart';
import 'features/checkout/application/checkout_services.dart';
import 'features/formValidation/bloc/bloc/form_bloc.dart';
import 'features/payment/application/bloc/payment_bloc.dart';
import 'features/products/application/blocs/bloc/product_bloc.dart';
import 'features/products/application/productService.dart';
import 'features/splash/splash_screen.dart';
import 'features/wishList/application/bloc/wishlist_bloc.dart';
import 'features/wishList/application/wishlist_serviecs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver(); // Set the observer for Blocs

  var displayname;
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(AuthenticationRepositoryImpl())
                ..add(AuthenticationStarted()),
        ),
        BlocProvider(
          create: (context) => FormBloc(
              AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        ),
        BlocProvider(
          create: (_) => CartBloc()..add(LoadCart()),
        ),
        BlocProvider(
          create: (_) => PaymentBloc()..add(LoadPaymentMethod()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            paymentBloc: context.read<PaymentBloc>(),
            checkoutRepository: CheckoutRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => WishlistBloc(
            localStorageRepository: LocalStorageRepository(),
          )..add(StartWishlist()),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategories(),
            ),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
      ],
      // child: const App(),
      child: MaterialApp(
        title: 'Anh TAi demo',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
      )));
}
