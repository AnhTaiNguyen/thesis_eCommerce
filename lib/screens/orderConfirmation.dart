import 'package:eCommerce/features/cart/application/bloc/cart_bloc.dart';
import 'package:eCommerce/reusable_widgets/Navbar.dart';
import 'package:eCommerce/reusable_widgets/customAppBar.dart';
import 'package:eCommerce/reusable_widgets/orderSummary.dart';
import 'package:eCommerce/reusable_widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const OrderConfirmation({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Confirmation'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded) {
            Map cart = state.cart.productQuantity(state.cart.products);
            return ListView(
              children: [
                const SizedBox(height: 20),
                // Order Complete Section
                Stack(
                  children: [
                    Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                    Positioned(
                      top: 250,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Your order is complete!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-Commerce,',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Thank you for purchasing on Shop E-Commerce.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'ORDER CODE: #k321-ekd3',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const OrderSummary(),
                      const SizedBox(height: 20),
                      Text(
                        'ORDER DETAILS',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 5),
                      // Order Details Section
                      for (int index = 0; index < cart.keys.length; index++)
                        ProductCard.summary(
                          product: cart.keys.elementAt(index),
                          quantity: cart.values.elementAt(index),
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something Wrong');
          }
        },
      ),
    );
  }
}
