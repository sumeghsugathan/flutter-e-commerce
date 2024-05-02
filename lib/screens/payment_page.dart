import 'package:flutter/material.dart';
import 'package:nikeapp/components/my_button.dart';
import 'package:nikeapp/components/my_radio_tile.dart';
import 'package:nikeapp/models/shop.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final double totalPrice;
  const PaymentPage({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Payment Methods",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Amount to be paid",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      totalPrice.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<Shop>(
                builder: (context, shop, child) => Column(
                  children: [
                    CustomRadioTile(
                      value: 1,
                      groupValue: shop.type,
                      onChanged: (value) {
                        shop.handleRadio(value as int);
                      },
                      title: "Amazon Pay",
                      imagePath: 'assets/images/amazon_pay.png',
                    ),
                    CustomRadioTile(
                      value: 2,
                      groupValue: shop.type,
                      onChanged: (value) {
                        shop.handleRadio(value as int);
                      },
                      title: "PhonePe",
                      imagePath: 'assets/images/phonepe.png',
                    ),
                    CustomRadioTile(
                        value: 3,
                        groupValue: shop.type,
                        onChanged: (value) {
                          shop.handleRadio(value as int);
                        },
                        title: "G Pay",
                        imagePath: 'assets/images/gpay.png'),
                    CustomRadioTile(
                      value: 4,
                      groupValue: shop.type,
                      onChanged: (value) {
                        shop.handleRadio(value as int);
                      },
                      title: "Paytm",
                      imagePath: 'assets/images/paytm.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: MyButton(
                  width: 150,
                  height: 70,
                  onTap: () {},
                  child: Text(
                    textAlign: TextAlign.center,
                    "Pay",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
