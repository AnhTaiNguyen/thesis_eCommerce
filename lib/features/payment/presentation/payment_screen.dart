import 'dart:io';

import 'package:eCommerce/reusable_widgets/googlePay.dart';
import 'package:eCommerce/screens/orderConfirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../../reusable_widgets/customAppBar.dart';
import '../../../reusable_widgets/navBar.dart';
import '../application/bloc/payment_bloc.dart';
import '../domain/payment_model.dart';

class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Selection'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Platform.isIOS
                    ? RawApplePayButton(
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.inStore,
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                                SelectPaymentMethod(
                                    paymentMethod: PaymentMethod.apple_pay),
                              );
                          Navigator.pop(context);
                        },
                      )
                    : RawGooglePayButton(
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                              const SelectPaymentMethod(
                                  paymentMethod: PaymentMethod.google_pay));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GooglePay(
                                      products: [],
                                      total: '',
                                    )),
                          );
                        },
                      ),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                          const SelectPaymentMethod(
                              paymentMethod: PaymentMethod.credit_card),
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderConfirmation()),
                    );
                  },
                  child: Text('Pay with Credit Card'),
                ),
              ],
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
