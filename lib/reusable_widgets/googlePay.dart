// import 'package:ecommerce/models/models.dart';
import 'package:flutter/material.dart';

import '../features/payment/presentation/payment_configurations.dart';
import '../features/products/domain/productModel.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatelessWidget {
  const GooglePay({
    Key? key,
    required this.total,
    required this.products,
  }) : super(key: key);

  final String total;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    var _paymentItems = products
        .map(
          (product) => PaymentItem(
              label: product.name,
              amount: product.price.toString(),
              type: PaymentItemType.item,
              status: PaymentItemStatus.final_price),
        )
        .toList();

    _paymentItems.add(
      PaymentItem(
        label: "Total",
        amount: total,
        type: PaymentItemType.total,
        status: PaymentItemStatus.final_price,
      ),
    );

    void onGooglePayResult(paymentResult) {
      debugPrint(paymentResult.toString());
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: GooglePayButton(
        paymentConfiguration:
            PaymentConfiguration.fromJsonString(defaultGooglePay),
        onPaymentResult: onGooglePayResult,
        paymentItems: _paymentItems,
        type: GooglePayButtonType.pay,
        margin: const EdgeInsets.only(top: 10),
        loadingIndicator: const CircularProgressIndicator(),
      ),
    );
  }
}
